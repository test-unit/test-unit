require_relative '../collector'

module Test
  module Unit
    module Collector
      class Descendant
        include Collector

        NAME = 'collected from the subclasses of TestCase'

        def collect(name=NAME, descendants=TestCase::DESCENDANTS)
          suite = TestSuite.new(name)
          add_test_cases(suite, descendants)
          adjust_ractor_tests(suite)
          suite
        end
      end
    end
  end
end
