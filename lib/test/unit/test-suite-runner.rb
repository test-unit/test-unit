#--
#
# Author:: Nathaniel Talbott.
# Copyright:: Copyright (c) 2000-2003 Nathaniel Talbott. All rights reserved.
# Copyright:: Copyright (c) 2008-2011 Kouhei Sutou. All rights reserved.
# Copyright:: Copyright (c) 2024 Tsutomu Katsube. All rights reserved.
# License:: Ruby license.

module Test
  module Unit
    class TestSuiteRunner
      class << self
        def run(test_suite, result, &progress_block)
          runner = new(test_suite)
          runner.run(result, &progress_block)
        end
      end

      def initialize(test_suite)
        @test_suite = test_suite
      end

      def run(result, &progress_block)
        yield(TestSuite::STARTED, @test_suite.name)
        yield(TestSuite::STARTED_OBJECT, @test_suite)
        run_startup(result)
        run_tests(result, &progress_block)
      ensure
        begin
          run_shutdown(result)
        ensure
          yield(TestSuite::FINISHED, @test_suite.name)
          yield(TestSuite::FINISHED_OBJECT, @test_suite)
        end
      end

      private
      def run_startup(result)
        test_case = @test_suite.test_case
        return if test_case.nil? or !test_case.respond_to?(:startup)
        begin
          test_case.startup
        rescue Exception
          raise unless handle_exception($!, result)
        end
      end

      def run_tests(result, &progress_block)
        @test_suite.tests.each do |test|
          run_test(test, result, &progress_block)
        end
      end

      def run_test(test, result)
        finished_is_yielded = false
        finished_object_is_yielded = false
        previous_event_name = nil
        test.run(result) do |event_name, *args|
          case previous_event_name
          when Test::Unit::TestCase::STARTED
            if event_name != Test::Unit::TestCase::STARTED_OBJECT
              yield(Test::Unit::TestCase::STARTED_OBJECT, test)
            end
          when Test::Unit::TestCase::FINISHED
            if event_name != Test::Unit::TestCase::FINISHED_OBJECT
              yield(Test::Unit::TestCase::FINISHED_OBJECT, test)
            end
            finished_object_is_yielded = true
          end

          case event_name
          when Test::Unit::TestCase::STARTED
            finished_is_yielded = false
            finished_object_is_yielded = false
          when Test::Unit::TestCase::FINISHED
            finished_is_yielded = true
          end

          previous_event_name = event_name
          yield(event_name, *args)
        end

        if finished_is_yielded and not finished_object_is_yielded
          yield(Test::Unit::TestCase::FINISHED_OBJECT, test)
        end
      end

      def run_shutdown(result)
        test_case = @test_suite.test_case
        return if test_case.nil? or !test_case.respond_to?(:shutdown)
        begin
          test_case.shutdown
        rescue Exception
          raise unless handle_exception($!, result)
        end
      end

      def handle_exception(exception, result)
        case exception
        when *ErrorHandler::PASS_THROUGH_EXCEPTIONS
          false
        else
          result.add_error(Error.new(@test_suite.test_case.name, exception))
          true
        end
      end
    end
  end
end

