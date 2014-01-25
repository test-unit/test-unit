require "test/unit"

module Test
  module Unit
    class TestTestSuiteCreator < TestCase
      def collect_test_names(test_case)
        creator = TestSuiteCreator.new(test_case)
        creator.send(:collect_test_names)
      end

      class TestInherited < self
        def setup
          @parent_test_case = Class.new(TestCase) do
            def test_in_parent
            end
          end

          @child_test_case = Class.new(@parent_test_case) do
            def test_in_child
            end
          end
        end

        def test_collect_test_names
          assert_equal(["test_in_child"], collect_test_names(@child_test_case))
        end
      end

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
        assert_equal(["test_1"], creator.send(:collect_test_names))
      end

      def test_collects_included_tests
        @test_case1.send(:include, @test_module)

        creator = TestSuiteCreator.new @test_case1
        assert_equal(["test_0", "test_1"], creator.send(:collect_test_names))
      end

      def test_skips_collecting_inherited_tests
        creator = TestSuiteCreator.new @test_case2
        assert_equal(["test_2"], creator.send(:collect_test_names))

        @test_case1.send(:include, @test_module)

        creator = TestSuiteCreator.new @test_case2
        assert_equal(["test_2"], creator.send(:collect_test_names))
      end
    end
  end
end
