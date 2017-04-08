# https://www.hackerrank.com/challenges/plus-minus

require 'test/unit'

class PlusMinusCalculatorTest < Test::Unit::TestCase
  def test_call
    expected_result = "0.5\n0.3333333333333333\n0.16666666666666666"
    assert_equal(expected_result, PlusMinusCalculator.new(6, [-4, 3, -9, 0, 4, 1]).call)
  end
end

class PlusMinusCalculator
  attr_reader :array_size, :array, :positive_numbers_count, :negative_numbers_count, :zeroes_count

  def initialize(array_size, array)
    @array_size = array_size
    @array = array
    @positive_numbers_count = 0
    @negative_numbers_count = 0
    @zeroes_count = 0
  end

  def call
    array.each do |ele|
      if ele > 0
        @positive_numbers_count += 1
      elsif ele < 0
        @negative_numbers_count += 1
      else
        @zeroes_count += 1
      end
    end

    positive_numbers_fraction = positive_numbers_count / array_size.to_f
    negative_numbers_fraction = negative_numbers_count / array_size.to_f
    zeroes_fraction = zeroes_count / array_size.to_f

    "#{positive_numbers_fraction}\n#{negative_numbers_fraction}\n#{zeroes_fraction}"
  end
end
