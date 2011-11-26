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
           "positive negative" => {:expected => -1, :augend => 1, :addend => -2})
      def test_plus(data)
        assert_equal(data[:expected],
                     @calc.plus(data[:augend], data[:addend]))
      end
    end

    class TestNData < TestCalc
      data("positive positive", {:expected => 4, :augend => 3, :addend => 1})
      data("positive negative", {:expected => -1, :augend => 1, :addend => -2})
      def test_plus(data)
        assert_equal(data[:expected],
                     @calc.plus(data[:augend], data[:addend]))
      end
    end

    class TestDynamicDataSet < TestCalc
      data do
        data_set = {}
        data_set["positive positive"] = {
          :expected => 3,
          :augend => 1,
          :addend => 2
        }
        data_set["positive negative"] = {
          :expected => -1,
          :augend => 1,
          :addend => -2
        }
        data_set
      end
      DATA_PROC = current_attribute(:data)[:value].first
      def test_plus(data)
        assert_equal(data[:expected],
                     @calc.plus(data[:augend], data[:addend]))
      end
    end

    class TestLoadDataSet < TestCalc
      base_dir = File.dirname(__FILE__)
      load_data("#{base_dir}/fixtures/plus.csv")
      def test_plus(data)
        assert_equal(data["expected"],
                     @calc.plus(data["augend"], data["addend"]))
      end
    end
  end

  def setup
    TestCalc.testing = true
  end

  def teardown
    TestCalc.testing = false
  end

  data("data set",
       {
         :test_case => TestCalc::TestDataSet,
         :data_set => [{
                         "positive positive" => {
                           :expected => 4,
                           :augend => 3,
                           :addend => 1,
                         },
                         "positive negative" => {
                           :expected => -1,
                           :augend => 1,
                           :addend => -2,
                         },
                       }],
       })
  data("n-data",
       {
         :test_case => TestCalc::TestNData,
         :data_set => [{
                         "positive positive" => {
                           :expected => 4,
                           :augend => 3,
                           :addend => 1,
                         },
                       },
                       {
                         "positive negative" => {
                           :expected => -1,
                           :augend => 1,
                           :addend => -2,
                         },
                       }],
       })
  data("dynamic-data-set",
       {
         :test_case => TestCalc::TestDynamicDataSet,
         :data_set => [TestCalc::TestDynamicDataSet::DATA_PROC],
       })
  data("load-data-set",
       {
         :test_case => TestCalc::TestLoadDataSet,
         :data_set => [{
                         "positive positive" => {
                           "expected" => 4,
                           "augend" => 3,
                           "addend" => 1,
                         },
                       },
                       {
                         "positive negative" => {
                           "expected" => -1,
                           "augend" => 1,
                           "addend" => -2,
                         },
                       }],
         })
  def test_data(data)
    test_plus = data[:test_case].new("test_plus")
    assert_equal(data[:data_set], test_plus[:data])
    assert_not_nil(data[:data_set])
  end

  data("data set" => TestCalc::TestDataSet,
       "n-data" => TestCalc::TestNData,
       "dynamic-data-set" => TestCalc::TestDynamicDataSet,
       "load-data-set" => TestCalc::TestLoadDataSet)
  def test_suite(test_case)
    suite = test_case.suite
    assert_equal(["test_plus[positive negative](#{test_case.name})",
                  "test_plus[positive positive](#{test_case.name})"],
                 suite.tests.collect {|test| test.name}.sort)
  end

  data("data set" => TestCalc::TestDataSet,
       "n-data" => TestCalc::TestNData,
       "dynamic-data-set" => TestCalc::TestDynamicDataSet,
       "load-data-set" => TestCalc::TestLoadDataSet)
  def test_run(test_case)
    result = _run_test(test_case)
    assert_equal("2 tests, 2 assertions, 0 failures, 0 errors, 0 pendings, " \
                 "0 omissions, 0 notifications", result.to_s)
  end

  data("data set" => TestCalc::TestDataSet,
       "n-data" => TestCalc::TestNData,
       "dynamic-data-set" => TestCalc::TestDynamicDataSet,
       "load-data-set" => TestCalc::TestLoadDataSet)
  def test_equal(test_case)
    suite = test_case.suite
    positive_positive_test = suite.tests.find do |test|
      test.data_label == "positive positive"
    end
    suite.tests.delete(positive_positive_test)
    assert_equal(["test_plus[positive negative](#{test_case.name})"],
                 suite.tests.collect {|test| test.name}.sort)
  end

  def _run_test(test_case)
    result = Test::Unit::TestResult.new
    test = test_case.suite
    yield(test) if block_given?
    test.run(result) {}
    result
  end
end
