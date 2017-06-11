# https://www.hackerrank.com/challenges/ctci-recursive-staircase

require 'test/unit'
require 'benchmark'

class StaircaseCalculatorTest < Test::Unit::TestCase
  def test_call
    assert_equal(1, StaircaseCalculator.new.call(1))
    assert_equal(2, StaircaseCalculator.new.call(2))
    assert_equal(4, StaircaseCalculator.new.call(3))
    assert_equal(7, StaircaseCalculator.new.call(4))
    assert_equal(13, StaircaseCalculator.new.call(5))
    assert_equal(44, StaircaseCalculator.new.call(7))
  end
end

class StaircaseCalculator
  attr_reader :results_cache

  def initialize
    @results_cache = {}
  end

  def call(number_of_steps)
    return 1 if number_of_steps == 1
    return 2 if number_of_steps == 2
    return 4 if number_of_steps == 3

    a = results_cache[number_of_steps - 3] || call(number_of_steps - 3)
    b = results_cache[number_of_steps - 2] || call(number_of_steps - 2)
    c = results_cache[number_of_steps - 1] || call(number_of_steps - 1)
    result = a + b + c
    @results_cache[number_of_steps] = result
    result
  end
end

class StaircaseCalculatorBenchmark
  NUMBERS = [10, 100, 1000, 10000]

  def call
    Benchmark.bm(20) do |b|
      NUMBERS.each do |number|
        b.report("number = #{number}") do
          StaircaseCalculator.new.call(number)
        end
      end
    end
  end
end

# StaircaseCalculatorBenchmark.new.call
#                            user     system      total        real
# number = 10            0.000000   0.000000   0.000000 (  0.000014)
# number = 100           0.000000   0.000000   0.000000 (  0.000066)
# number = 1000          0.000000   0.000000   0.000000 (  0.000949)
# number = 10000         0.020000   0.000000   0.020000 (  0.018769)
