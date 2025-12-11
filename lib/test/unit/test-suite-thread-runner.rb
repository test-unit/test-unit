#--
#
# Author:: Tsutomu Katsube.
# Copyright:: Copyright (c) 2024-2025 Tsutomu Katsube. All rights reserved.
# License:: Ruby license.

require_relative "sub-test-result"
require_relative "test-suite-runner"
require_relative "test-thread-run-context"

module Test
  module Unit
    class TestSuiteThreadRunner < TestSuiteRunner
      class << self
        def run_all_tests(result, options)
          n_workers = TestSuiteRunner.n_workers

          queue = Thread::Queue.new
          shutdowns = []
          yield(TestThreadRunContext.new(self, queue, shutdowns))
          n_workers.times do
            queue << nil
          end

          workers = []
          sub_exceptions = []
          n_workers.times do |i|
            workers << Thread.new(i) do |worker_id|
              begin
                loop do
                  task = queue.pop
                  break if task.nil?
                  catch do |stop_tag|
                    task.call(stop_tag)
                  end
                end
              rescue Exception => exception
                sub_exceptions << exception
              end
            end
          end
          workers.each(&:join)

          shutdowns.each(&:call)
          sub_exceptions.each do |exception|
            raise exception
          end
        end
      end

      def run(worker_context, &progress_block)
        yield(TestSuite::STARTED, @test_suite.name)
        yield(TestSuite::STARTED_OBJECT, @test_suite)
        run_startup(worker_context)
        run_tests(worker_context, &progress_block)
      ensure
        worker_context.run_context.shutdowns << lambda do
          begin
            run_shutdown(worker_context)
          ensure
            yield(TestSuite::FINISHED, @test_suite.name)
            yield(TestSuite::FINISHED_OBJECT, @test_suite)
          end
        end
      end

      private
      def run_tests(worker_context, &progress_block)
        run_context = worker_context.run_context
        @test_suite.tests.each do |test|
          if test.is_a?(TestSuite) or not @test_suite.parallel_safe?
            run_test(test, worker_context, &progress_block)
          else
            task = lambda do |stop_tag|
              sub_result = SubTestResult.new(worker_context.result)
              sub_result.stop_tag = stop_tag
              sub_worker_context = WorkerContext.new(nil, run_context, sub_result)
              run_test(test, sub_worker_context, &progress_block)
            end
            run_context.queue << task
          end
        end
      end
    end
  end
end
