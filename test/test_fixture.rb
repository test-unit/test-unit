class TestFixture < Test::Unit::TestCase
  def test_setup
    called = []
    test_case = Class.new(Test::Unit::TestCase) do
      @@called = called
      def setup
        @@called << :setup
      end

      setup
      def custom_setup_method
        @@called << :custom_setup_method
      end

      def custom_setup_method2
        @@called << :custom_setup_method2
      end
      setup :custom_setup_method2

      setup
      def custom_setup_method3
        @@called << :custom_setup_method3
      end
      unregister_setup(:custom_setup_method3)

      def test_nothing
      end
    end

    test_case.new("test_nothing").run(Test::Unit::TestResult.new) {}
    assert_equal([:setup, :custom_setup_method, :custom_setup_method2],
                 called)
  end

  def test_teardown
    called = []
    test_case = Class.new(Test::Unit::TestCase) do
      @@called = called
      def teardown
        @@called << :teardown
      end

      teardown
      def custom_teardown_method
        @@called << :custom_teardown_method
      end

      def custom_teardown_method2
        @@called << :custom_teardown_method2
      end
      teardown :custom_teardown_method2

      teardown
      def custom_teardown_method3
        @@called << :custom_teardown_method3
      end
      unregister_teardown(:custom_teardown_method3)

      def test_nothing
      end
    end

    test_case.new("test_nothing").run(Test::Unit::TestResult.new) {}
    assert_equal([:teardown, :custom_teardown_method, :custom_teardown_method2],
                 called)
  end
end
