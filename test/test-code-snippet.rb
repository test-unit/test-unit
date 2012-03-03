require "test-unit"
require "stringio"

class TestCodeSnippet < Test::Unit::TestCase
  class TestErrorInsideJRuby < Test::Unit::TestCase
    class << self
      def suite
        Test::Unit::TestSuite.new(name)
      end
    end

    def test_exception_from_java
      require 'java'
      java.util.Vector.new(-1)
    end
  end

  def test_error_inside_jruby
    omit("Skipping test for JRuby") unless RUBY_PLATFORM =~ /java/

    suite = TestErrorInsideJRuby.suite
    suite << TestErrorInsideJRuby.new("test_exception_from_java")

    output = StringIO.new
    runner = Test::Unit::UI::Console::TestRunner.new(suite, :output => output)
    result = runner.start

    assert_equal("1 tests, 0 assertions, 0 failures, " +
                 "1 errors, 0 pendings, 0 omissions, 0 notifications",
                 result.summary)
  end
end
