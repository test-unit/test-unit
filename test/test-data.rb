class TestData < Test::Unit::TestCase
  class TestCalc < Test::Unit::TestCase
    @@testing = false

    class << self
      def testing=(testing)
        @@testing = testing
      end
    end

    def valid?
      @@testing
    end

    class Calc
      def initialize
      end

      def plus(augend, addend)
        augend + addend
      end
    end

    def setup
      @calc = Calc.new
    end

    data("positive positive" => {:expected => 4, :augend => 3, :addend => 1},
         "positive negative" => {:expected => 2, :augend => 5, :addend => -3})
    def test_plus(data)
      assert_equal(data[:expected],
                   @calc.plus(data[:augend], data[:addend]))
    end
  end

  def setup
    TestCalc.testing = true
  end

  def teardown
    TestCalc.testing = false
  end

  def test_data
    test_plus = TestCalc.new("test_plus")
    assert_equal({
                   "positive positive" => {
                     :expected => 4,
                     :augend => 3,
                     :addend => 1,
                   },
                   "positive negative" => {
                     :expected => 2,
                     :augend => 5,
                     :addend => -3,
                   },
                 },
                 test_plus[:data])
  end

  def test_suite
    suite = TestCalc.suite
    assert_equal(["test_plus[positive positive](TestData::TestCalc)",
                  "test_plus[positive negative](TestData::TestCalc)"],
                 suite.tests.collect {|test| test.name})
  end

  def test_run
    result = _run_test(TestCalc)
    assert_equal("2 tests, 2 assertions, 0 failures, 0 errors, 0 pendings, " \
                 "0 omissions, 0 notifications", result.to_s)
  end

  def _run_test(test_case)
    result = Test::Unit::TestResult.new
    test = test_case.suite
    yield(test) if block_given?
    test.run(result) {}
    result
  end
end
