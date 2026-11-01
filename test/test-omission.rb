require 'test/unit'
require_relative 'testunit-test-util'

class TestUnitOmission < Test::Unit::TestCase
  include TestUnitTestUtil

  class TestCase < Test::Unit::TestCase
    class << self
      def suite
        Test::Unit::TestSuite.new(name)
      end
    end

    def test_omit
      omit("Omit")
      flunk("Should not be reached here.")
    end

    def test_omit_with_condition
      omit_if(false, "Never omit.")
      omit_unless(true, "Never omit too.")
      omit_if(true, "Should omit.")
      omit("The last omit. Should not be reached here.")
    end

    def test_omit_with_block
      omit("Omit block") do
        flunk("Should not be reached here.")
      end
      assert(true, "Should be reached here.")
    end

    def test_omit_with_block_and_condition
      omit_if(false, "Never omit.") do
        assert(true, "Should be reached here.")
      end
      omit_if(true, "Should omit.") do
        flunk("Never reached here.")
      end
      assert(true, "Should be reached here too.")
    end

    def test_skip
      skip("Skip")
      flunk("Should not be reached here.")
    end

    def test_skip_without_message
      skip
    end

    def test_skip_with_ignored_argument
      skip("Ignore the 2nd argument", caller)
    end
  end

  def test_omit
    result = _run_test("test_omit")
    assert_equal("1 tests, 0 assertions, 0 failures, 0 errors, 0 pendings, " \
                 "1 omissions, 0 notifications",
                 result.to_s)
    assert_fault_messages(["Omit"], result.omissions)
  end

  def test_omit_with_condition
    result = _run_test("test_omit_with_condition")
    assert_equal("1 tests, 0 assertions, 0 failures, 0 errors, 0 pendings, " \
                 "1 omissions, 0 notifications",
                 result.to_s)
    assert_fault_messages(["Should omit."], result.omissions)
  end

  def test_omit_with_block
    result = _run_test("test_omit_with_block")
    assert_equal("1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, " \
                 "1 omissions, 0 notifications",
                 result.to_s)
    assert_fault_messages(["Omit block"], result.omissions)
  end

  def test_omit_with_condition_and_block
    result = _run_test("test_omit_with_block_and_condition")
    assert_equal("1 tests, 2 assertions, 0 failures, 0 errors, 0 pendings, " \
                 "1 omissions, 0 notifications",
                 result.to_s)
    assert_fault_messages(["Should omit."], result.omissions)
  end

  def test_skip
    result = _run_test("test_skip")
    assert_equal("1 tests, 0 assertions, 0 failures, 0 errors, 0 pendings, " \
                 "1 omissions, 0 notifications",
                 result.to_s)
    assert_fault_messages(["Skip"], result.omissions)
  end

  def test_skip_without_message
    result = _run_test("test_skip_without_message")
    assert_fault_messages(["skipped."], result.omissions)
  end

  def test_skip_with_ignored_argument
    result = _run_test("test_skip_with_ignored_argument")
    assert_fault_messages(["Ignore the 2nd argument"], result.omissions)
  end

  private
  def _run_test(name)
    super(TestCase, name)
  end
end
