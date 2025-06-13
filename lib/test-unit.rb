# Copyright (C) 2012-2015  Kouhei Sutou <kou@clear-code.com>

require_relative "test/unit/warning"

module Test
  module Unit
    LAZY_LOADER_MAPPING = {
      :TestCase => "test/unit/testcase",
      :AutoRunner => "test/unit/autorunner",
    }

    class << self
      def const_missing(name)
        if LAZY_LOADER_MAPPING.key?(name)
          require_relative LAZY_LOADER_MAPPING[name]
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
