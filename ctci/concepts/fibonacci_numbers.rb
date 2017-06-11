# https://www.hackerrank.com/challenges/ctci-fibonacci-numbers

require 'test/unit'
require 'benchmark'

class FibonacciCalculatorTest < Test::Unit::TestCase
  def test_call
    assert_equal(0, FibonacciCalculator.new.call(0))
    assert_equal(1, FibonacciCalculator.new.call(1))
    assert_equal(1, FibonacciCalculator.new.call(2))
    assert_equal(2, FibonacciCalculator.new.call(3))
    assert_equal(3, FibonacciCalculator.new.call(4))
    assert_equal(5, FibonacciCalculator.new.call(5))
    assert_equal(8, FibonacciCalculator.new.call(6))
  end
end

class FibonacciCalculator
  attr_reader :results_cache

  def initialize
    @results_cache = {}
  end

  def call(number)
    return 0 if number == 0
    return 1 if number == 1

    a = results_cache[number - 2] || call(number - 2)
    b = results_cache[number - 1] || call(number - 1)
    result = a + b
    @results_cache[number] = result
    result
  end
end

class FibonacciCalculatorBenchmark
  NUMBERS = [10, 100, 1000, 10000]

  def call
    Benchmark.bm(20) do |b|
      NUMBERS.each do |number|
        b.report("number = #{number}") do
          FibonacciCalculator.new.call(number)
        end
      end
    end
  end
end

# FibonacciCalculatorBenchmark.new.call
#                            user     system      total        real
# number = 10            0.000000   0.000000   0.000000 (  0.000011)
# number = 100           0.000000   0.000000   0.000000 (  0.000085)
# number = 1000          0.000000   0.000000   0.000000 (  0.000687)
# number = 10000         0.010000   0.000000   0.010000 (  0.010426)
