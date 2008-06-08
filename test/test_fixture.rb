class TestUnitFixture < Test::Unit::TestCase
  def test_setup_without_option
    test_case = assert_setup([:setup,
                              :custom_setup_method0,
                              :custom_setup_method1,
                              :custom_setup_method3],
                             [])
    assert_inherited_setup([:setup,
                            :custom_setup_method0,
                            :custom_setup_method1,
                            :custom_setup_method3],
                           test_case)
    assert_inherited_setup([:setup], nil)
  end

  def test_setup_with_before_option
    test_case = assert_setup([:custom_setup_method3,
                              :custom_setup_method0,
                              :custom_setup_method1,
                              :setup],
                             [[{:before => :append}],
                              [{:before => :append}],
                              [{:before => :prepend}],
                              [{:before => :prepend}]])
    assert_inherited_setup([:custom_setup_method3,
                            :custom_setup_method0,
                            :custom_setup_method1,
                            :setup],
                           test_case)
    assert_inherited_setup([:setup], nil)
  end

  def test_setup_with_after_option
    test_case = assert_setup([:setup,
                              :custom_setup_method3,
                              :custom_setup_method0,
                              :custom_setup_method1],
                             [[{:after => :append}],
                              [{:after => :append}],
                              [{:after => :prepend}],
                              [{:after => :prepend}]])
    assert_inherited_setup([:setup,
                            :custom_setup_method3,
                            :custom_setup_method0,
                            :custom_setup_method1],
                           test_case)
    assert_inherited_setup([:setup], nil)
  end

  def test_setup_with_invalid_option
    assert_invalid_setup_option(:unknown => true)
    assert_invalid_setup_option(:before => :unknown)
    assert_invalid_setup_option(:after => :unknown)
  end

  def test_teardown_without_option
    test_case = assert_teardown([:custom_teardown_method3,
                                 :custom_teardown_method1,
                                 :custom_teardown_method0,
                                 :teardown],
                                [])
    assert_inherited_teardown([:custom_teardown_method3,
                               :custom_teardown_method1,
                               :custom_teardown_method0,
                               :teardown],
                              test_case)
    assert_inherited_teardown([:teardown], nil)
  end

  def test_teardown_with_before_option
    test_case = assert_teardown([:custom_teardown_method3,
                                 :custom_teardown_method0,
                                 :custom_teardown_method1,
                                 :teardown],
                                [[{:before => :append}],
                                 [{:before => :append}],
                                 [{:before => :prepend}],
                                 [{:before => :prepend}]])
    assert_inherited_teardown([:custom_teardown_method3,
                               :custom_teardown_method0,
                               :custom_teardown_method1,
                               :teardown],
                              test_case)
    assert_inherited_teardown([:teardown], nil)
  end

  def test_teardown_with_after_option
    test_case = assert_teardown([:teardown,
                                 :custom_teardown_method3,
                                 :custom_teardown_method0,
                                 :custom_teardown_method1],
                                [[{:after => :append}],
                                 [{:after => :append}],
                                 [{:after => :prepend}],
                                 [{:after => :prepend}]])
    assert_inherited_teardown([:teardown,
                               :custom_teardown_method3,
                               :custom_teardown_method0,
                               :custom_teardown_method1],
                              test_case)
    assert_inherited_teardown([:teardown], nil)
  end

  def test_teardown_with_invalid_option
    assert_invalid_teardown_option(:unknown => true)
    assert_invalid_teardown_option(:before => :unknown)
    assert_invalid_teardown_option(:after => :unknown)
  end

  private
  def assert_setup(expected, setup_options)
    called = []
    test_case = Class.new(Test::Unit::TestCase) do
      @@called = called
      def setup
        @@called << :setup
      end

      setup(*(setup_options[0] || []))
      def custom_setup_method0
        @@called << :custom_setup_method0
      end

      def custom_setup_method1
        @@called << :custom_setup_method1
      end
      setup(*[:custom_setup_method1, *(setup_options[1] || [])])

      setup(*(setup_options[2] || []))
      def custom_setup_method2
        @@called << :custom_setup_method2
      end
      unregister_setup(:custom_setup_method2)

      setup(*(setup_options[3] || []))
      def custom_setup_method3
        @@called << :custom_setup_method3
      end

      def test_nothing
      end
    end

    test_case.new("test_nothing").run(Test::Unit::TestResult.new) {}
    assert_equal(expected, called)
    test_case
  end

  def assert_inherited_setup(expected, parent)
    called = []
    inherited_test_case = Class.new(parent || Test::Unit::TestCase) do
      @@called = called
      def setup
        @@called << :setup
      end

      def custom_setup_method0
        @@called << :custom_setup_method0
      end

      def custom_setup_method1
        @@called << :custom_setup_method1
      end

      def custom_setup_method2
        @@called << :custom_setup_method2
      end

      def custom_setup_method3
        @@called << :custom_setup_method3
      end

      def test_nothing
      end
    end

    inherited_test_case.new("test_nothing").run(Test::Unit::TestResult.new) {}
    assert_equal(expected, called)
  end

  def assert_teardown(expected, teardown_options)
    called = []
    test_case = Class.new(Test::Unit::TestCase) do
      @@called = called
      def teardown
        @@called << :teardown
      end

      teardown(*(teardown_options[0] || []))
      def custom_teardown_method0
        @@called << :custom_teardown_method0
      end

      def custom_teardown_method1
        @@called << :custom_teardown_method1
      end
      teardown(*[:custom_teardown_method1, *(teardown_options[1] || [])])

      teardown(*(teardown_options[2] || []))
      def custom_teardown_method2
        @@called << :custom_teardown_method2
      end
      unregister_teardown(:custom_teardown_method2)

      teardown(*(teardown_options[3] || []))
      def custom_teardown_method3
        @@called << :custom_teardown_method3
      end

      def test_nothing
      end
    end

    test_case.new("test_nothing").run(Test::Unit::TestResult.new) {}
    assert_equal(expected, called)
    test_case
  end

  def assert_inherited_teardown(expected, parent)
    called = []
    inherited_test_case = Class.new(parent || Test::Unit::TestCase) do
      @@called = called
      def teardown
        @@called << :teardown
      end

      def custom_teardown_method0
        @@called << :custom_teardown_method0
      end

      def custom_teardown_method1
        @@called << :custom_teardown_method1
      end

      def custom_teardown_method2
        @@called << :custom_teardown_method2
      end

      def custom_teardown_method3
        @@called << :custom_teardown_method3
      end

      def test_nothing
      end
    end

    inherited_test_case.new("test_nothing").run(Test::Unit::TestResult.new) {}
    assert_equal(expected, called)
  end

  def assert_invalid_option(fixture_type, option)
    exception = assert_raise(ArgumentError) do
      Class.new(Test::Unit::TestCase) do
        def test_nothing
        end

        send(fixture_type, option)
        def fixture
        end
      end
    end
    assert_equal("must be {:before => :prepend}, {:before => :append}, " +
                 "{:after => :prepend} or {:after => :append}" +
                 ": #{option.inspect}",
                 exception.message)
  end

  def assert_invalid_setup_option(option)
    assert_invalid_option(:setup, option)
  end

  def assert_invalid_teardown_option(option)
    assert_invalid_option(:teardown, option)
  end
end
