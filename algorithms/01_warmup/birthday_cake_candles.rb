# https://www.hackerrank.com/challenges/birthday-cake-candles

require 'test/unit'

class CandlesCalculatorTest < Test::Unit::TestCase
  def test_call
    assert_equal(2, CandlesCalculator.new(4, [3, 2, 1, 3]).call)
  end
end

class CandlesCalculator
  attr_reader :number_of_candles, :candles_array

  def initialize(number_of_candles, candles_array)
    @number_of_candles = number_of_candles
    @candles_array = candles_array
  end

  def call
    max_height = candles_array.max
    candles_array.count { |ele| ele == max_height }
  end
end
