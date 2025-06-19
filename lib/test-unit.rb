# Copyright (C) 2012-2015  Kouhei Sutou <kou@clear-code.com>

require_relative "test/unit/warning"

module Test
  module Unit
    class << self
      def const_missing(name)
        case name
        when :AutoRunner, :TestCase
          require_relative "test/unit/autorunner"
          require_relative "test/unit/testcase"
          singleton_class.remove_method(:const_missing)
          const_get(name)
        else
          super
        end
      end
    end
  end
end

unless respond_to?(:run_test, true)
  # experimental. It is for "ruby -rtest-unit -e run_test test/test_*.rb".
  # Is this API OK or dirty?
  def run_test
    self.class.send(:undef_method, :run_test)
    require_relative "test/unit"
  end
end
