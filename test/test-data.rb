class TestData < Test::Unit::TestCase
  class Calc
    def initialize
    end

    def plus(augend, addend)
      augend + addend
    end
  end

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

    def setup
      @calc = Calc.new
    end

    class TestDataSet < TestCalc
      data("positive positive" => {:expected => 4, :augend => 3, :addend => 1},
           "positive negative" => {:expected => 2, :augend => 5, :addend => -3})
      def test_plus(data)
        assert_equal(data[:expected],
                     @calc.plus(data[:augend], data[:addend]))
      end
    end

    class TestNData < TestCalc
      data("positive positive", {:expected => 4, :augend => 3, :addend => 1})
      data("positive negative", {:expected => 2, :augend => 5, :addend => -3})
      def test_plus(data)
        assert_equal(data[:expected],
                     @calc.plus(data[:augend], data[:addend]))
      end
    end
  end

  def setup
    TestCalc.testing = true
  end

  def teardown
    TestCalc.testing = false
  end

  data("data set" => TestCalc::TestDataSet,
       "n-data" => TestCalc::TestNData)
  def test_data(test_case)
    test_plus = test_case.new("test_plus")
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

  data("data set" => TestCalc::TestDataSet,
       "n-data" => TestCalc::TestNData)
  def test_suite(test_case)
    suite = test_case.suite
    assert_equal(["test_plus[positive positive](#{test_case.name})",
                  "test_plus[positive negative](#{test_case.name})"],
                 suite.tests.collect {|test| test.name})
  end

  data("data set" => TestCalc::TestDataSet,
       "n-data" => TestCalc::TestNData)
  def test_run(test_case)
    result = _run_test(test_case)
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
