module TestUnitTestUtil
  private
  def jruby_only_test
    begin
      require "java"
    rescue LoadError
      omit("test for JRuby")
    end
  end

  def assert_fault_messages(expected, faults)
    assert_equal(expected, faults.collect {|fault| fault.message})
  end

  def _run_test(test_case, name)
    result = Test::Unit::TestResult.new
    test = test_case.new(name)
    yield(test) if block_given?
    test.run(result) {}
    result
  end
end
