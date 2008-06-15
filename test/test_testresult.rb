# Author:: Nathaniel Talbott.
# Copyright:: Copyright (c) 2000-2002 Nathaniel Talbott. All rights reserved.
# License:: Ruby license.

require 'test/unit/testcase'
require 'test/unit/testresult'

module Test
  module Unit
    class TC_TestResult < TestCase
      def setup
        @my_result = TestResult.new
        @my_result.add_assertion()
        @failure = "failure"
        @my_result.add_failure(@failure)
        @error = "error"
        @my_result.add_error(@error)
      end

      def test_result_changed_notification
        called1 = false
        @my_result.add_listener(TestResult::CHANGED) do |result|
          assert_equal(@my_result, result, "The result should be correct")
          called1 = true
        end
        @my_result.add_assertion
        assert(called1, "Should have been notified when the assertion happened")

        called1, called2 = false, false
        @my_result.add_listener(TestResult::CHANGED) do |result|
          assert_equal(@my_result, result, "The result should be correct")
          called2 = true
        end
        @my_result.add_assertion
        assert(called1 && called2,
               "Both listeners should have been notified for a success")

        called1, called2 = false, false
        @my_result.add_failure("")
        assert(called1 && called2,
               "Both listeners should have been notified for a failure")

        called1, called2 = false, false
        @my_result.add_error("")
        assert(called1 && called2,
               "Both listeners should have been notified for an error")

        called1, called2 = false, false
        @my_result.add_run
        assert(called1 && called2,
               "Both listeners should have been notified for a run")
      end

      def test_fault_notification
        called1 = false
        fault = "fault"
        @my_result.add_listener(TestResult::FAULT) do |passed_fault|
          assert_equal(fault, passed_fault, "The fault should be correct")
          called1 = true
        end

        @my_result.add_assertion
        assert(!called1,
               "Should not have been notified when the assertion happened")

        @my_result.add_failure(fault)
        assert(called1, "Should have been notified when the failure happened")

        called1, called2 = false, false
        @my_result.add_listener(TestResult::FAULT) do |passed_fault|
          assert_equal(fault, passed_fault, "The fault should be correct")
          called2 = true
        end

        @my_result.add_assertion
        assert(!(called1 || called2),
               "Neither listener should have been notified for a success")

        called1, called2 = false, false
        @my_result.add_failure(fault)
        assert(called1 && called2,
               "Both listeners should have been notified for a failure")

        called1, called2 = false, false
        @my_result.add_error(fault)
        assert(called1 && called2,
               "Both listeners should have been notified for an error")

        called1, called2 = false, false
        @my_result.add_run
        assert(!(called1 || called2),
               "Neither listener should have been notified for a run")
      end

      def test_passed?
        result = TestResult.new
        assert(result.passed?, "An empty result should have passed")

        result.add_assertion
        assert(result.passed?,
               "Adding an assertion should not cause the result to not pass")

        result.add_run
        assert(result.passed?,
               "Adding a run should not cause the result to not pass")

        result.add_failure("")
        assert(!result.passed?,
               "Adding a failed assertion should cause the result to not pass")

        result = TestResult.new
        result.add_error("")
        assert(!result.passed?,
               "Adding an error should cause the result to not pass")
      end

      def test_faults
        assert_equal([@failure, @error], @my_result.faults)

        notification = "notification"
        @my_result.add_notification(notification)
        assert_equal([@failure, @error, notification], @my_result.faults)
      end
    end
  end
end
