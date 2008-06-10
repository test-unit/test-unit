require 'test/unit'
require 'testunit_test_util'

class TestUnitPending < Test::Unit::TestCase
  include TestUnitTestUtil

  class TestCase < Test::Unit::TestCase
    class << self
      def suite
        Test::Unit::TestSuite.new(name)
      end
    end

    def test_pend
      pend("1st pend")
      pend("2nd pend. Should not be reached here.")
      assert(true, "Should not be reached here too.")
    end

    def test_pend_with_failure_in_block
      pend("Wait a minute") do
        raise "Not implemented yet"
      end
      assert(true, "Reached here.")
    end

    def test_pend_with_no_failure_in_block
      pend("Wait a minute") do
        "Nothing raised"
      end
      assert(true, "Not reached here.")
    end
  end

  def test_pend
    result = run_test("test_pend")
    assert_equal("1 tests, 0 assertions, 0 failures, 0 errors, 1 pendings, " \
                 "0 omissions",
                 result.to_s)
    assert_fault_messages(["1st pend"], result.pendings)
  end

  def test_pend_with_failure_in_block
    result = run_test("test_pend_with_failure_in_block")
    assert_equal("1 tests, 1 assertions, 0 failures, 0 errors, 1 pendings, " \
                 "0 omissions",
                 result.to_s)
    assert_fault_messages(["Wait a minute"], result.pendings)
  end

  def test_pend_with_no_failure_in_block
    result = run_test("test_pend_with_no_failure_in_block")
    assert_equal("1 tests, 1 assertions, 1 failures, 0 errors, 0 pendings, " \
                 "0 omissions",
                 result.to_s)
    assert_fault_messages(["Pending block should not be passed: Wait a minute."],
                          result.failures)
  end

  private
  def run_test(name)
    super(TestCase, name)
  end
end
