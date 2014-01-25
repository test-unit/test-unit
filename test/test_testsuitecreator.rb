require 'test/unit'

module Test
  module Unit
    class TestTestSuiteCreator < TestCase
      def setup

        @test_module = Module.new do
          def test_0; end
        end

        @test_case1 = Class.new(TestCase) do
          self.test_order = :alphabetic
          def test_1; end
        end

        @test_case2 = Class.new(@test_case1) do
          def test_2; end
        end

      end

      def test_collects_tests
        creator = TestSuiteCreator.new @test_case1
        assert_equal [ 'test_1' ], creator.send(:collect_test_names)
      end

      def test_collects_included_tests
        @test_case1.send(:include, @test_module)

        creator = TestSuiteCreator.new @test_case1
        assert_equal [ 'test_0', 'test_1' ], creator.send(:collect_test_names)
      end

      def test_skips_collecting_inherited_tests
        creator = TestSuiteCreator.new @test_case2
        assert_equal [ 'test_2' ], creator.send(:collect_test_names)

        @test_case1.send(:include, @test_module)
        
        creator = TestSuiteCreator.new @test_case2
        assert_equal [ 'test_2' ], creator.send(:collect_test_names)
      end

    end
  end
end
