require 'test/unit'
require 'stringio'

class TestJRuby < Test::Unit::TestCase
  class TestCase < Test::Unit::TestCase
    class << self
      def suite
        Test::Unit::TestSuite.new(name)
      end
    end

    def test_java_exception_output
      require 'java'
      java.util.Vector.new -1
    end
  end

  def test_java_exception_output
    omit("Skipping test for JRuby") unless RUBY_PLATFORM =~ /java/

    suite = TestCase.suite
    suite << TestCase.new('test_java_exception_output')

    output = StringIO.new
    runner = Test::Unit::UI::Console::TestRunner.new(suite, :output => output)
    result = runner.start

    assert_equal 1, result.faults.size
  end
end

