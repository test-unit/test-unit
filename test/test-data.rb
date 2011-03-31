class TestData < Test::Unit::TestCase
  class TestCalc < Test::Unit::TestCase
    class << self
      def suite
        Test::Unit::TestSuite.new(name)
      end
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

    data({"positive positive" => {:expected => 4, :augend => 3, :addend => 1}})
    def test_plus(data)
      assert_equal(data[:expected], add(data[:augend], data[:addend]))
    end

  end

  def test_data
    test_plus = TestCalc.new("test_plus")
    assert_equal({"positive positive" => {:expected => 4, :augend => 3, :addend => 1}},
                 test_plus.attribute("data"))
  end
end
