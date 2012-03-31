module Test
  module Unit
    autoload :TestCase, "test/unit/testcase"
    autoload :AutoRunner, "test/unit/autorunner"
  end
end

# experimental. It is for "ruby -rtest-unit -e run test/test_*.rb".
# Is this API OK or dirty?
def run
  self.class.send(:undef_method, :run)
  require "test/unit"
end
