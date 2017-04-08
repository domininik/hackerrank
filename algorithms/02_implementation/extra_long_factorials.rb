# https://www.hackerrank.com/challenges/extra-long-factorials

require 'test/unit'

class FactorialTest < Test::Unit::TestCase
  def test_calculate
    assert_equal(15511210043330985984000000, Factorial.new.calculate(25))
  end
end

class Factorial
  def calculate(n)
    (1..n).reduce(:*)
  end
end
