# https://www.hackerrank.com/challenges/mini-max-sum

require 'test/unit'

class MinMaxCalculatorTest < Test::Unit::TestCase
  def test_call
    assert_equal('10 14', MinMaxCalculator.new.call(1, 2, 3, 4, 5))
  end
end

class MinMaxCalculator
  def call(*numbers)
    sorted_array = numbers.to_a.sort
    min_value = sorted_array.first(4).reduce(:+)
    max_value = sorted_array.last(4).reduce(:+)
    "#{min_value} #{max_value}"
  end
end
