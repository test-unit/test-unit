# Copyright (C) 2012  Kouhei Sutou <kou@clear-code.com>
#
# License: Ruby's

require "test-unit"
require "test/unit/fault-location-detector"
require "testunit-test-util"

class TestFaultLocationDetector < Test::Unit::TestCase
  include TestUnitTestUtil

  def setup
    @fetcher = Test::Unit::CodeSnippetFetcher.new
  end

  private
  def run_test_case(test_case)
    suite = test_case.suite
    result = Test::Unit::TestResult.new
    suite.run(result) {}
    result.faults[0]
  end

  def assert_detect(fault, target_line_number)
    detector = Test::Unit::FaultLocationDetector.new(fault, @fetcher)

    expected = fault.location.collect do |backtrace_entry|
      _, line_number, = detector.split_backtrace_entry(backtrace_entry)
      [backtrace_entry, target_line_number == line_number]
    end
    actual = fault.location.collect do |backtrace_entry|
      [backtrace_entry, detector.target?(backtrace_entry)]
    end
    assert_equal(expected, actual)
  end

  module AlwaysFailAssertion
    private
    def assert_always_failed
      assert_true(false)
    end
  end

  class TestSourceLocation < self
    def test_detected
      target_line_number = nil
      test_case = Class.new(Test::Unit::TestCase) do
        include AlwaysFailAssertion

        test "failed" do
          target_line_number = __LINE__; assert_always_failed
        end
      end

      fault = run_test_case(test_case)
      assert_detect(fault, target_line_number)
    end

    class TestOneLine < self
      def test_brace
        target_line_number = nil
        test_case = Class.new(Test::Unit::TestCase) do
          include AlwaysFailAssertion

          test("failed") {target_line_number = __LINE__; assert_always_failed}

          def other_method
            # body
          end
        end

        fault = run_test_case(test_case)
        assert_detect(fault, target_line_number)
      end

      def test_do_end
        target_line_number = nil
        test_case = Class.new(Test::Unit::TestCase) do
          include AlwaysFailAssertion

          test "failed" do target_line_number = __LINE__; assert_always_failed; end

          def other_method
            # body
          end
        end

        fault = run_test_case(test_case)
        assert_detect(fault, target_line_number)
      end
    end
  end

  class TestMethodName < self
    def test_detected
      test_case = Class.new(Test::Unit::TestCase) do
        include AlwaysFailAssertion

        @@target_line_number = nil
        class << self
          def target_line_number
            @@target_line_number
          end
        end

        def test_failed
          @@target_line_number = __LINE__; assert_always_failed
        end
      end

      fault = run_test_case(test_case)
      assert_detect(fault, test_case.target_line_number)
    end
  end
end
