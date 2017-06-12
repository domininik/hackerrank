# https://www.hackerrank.com/challenges/ctci-big-o

require 'test/unit'
require 'benchmark'

class PrimalityValidatorTest < Test::Unit::TestCase
  def test_call
    assert_equal('Not prime', PrimalityValidator.new(1).call)
    assert_equal('Prime', PrimalityValidator.new(2).call)
    assert_equal('Prime', PrimalityValidator.new(3).call)
    assert_equal('Not prime', PrimalityValidator.new(4).call)
    assert_equal('Prime', PrimalityValidator.new(5).call)
    assert_equal('Not prime', PrimalityValidator.new(6).call)
    assert_equal('Prime', PrimalityValidator.new(7).call)
    assert_equal('Not prime', PrimalityValidator.new(12).call)
    assert_equal('Prime', PrimalityValidator.new(37).call)
  end
end

class PrimalityValidator
  PRIME = 'Prime'
  NOT_PRIME = 'Not prime'

  def initialize(number)
    @number = number
  end

  def call
    return NOT_PRIME if number == 1
    return PRIME if [2, 3].include?(number)

    divisors.each do |value|
      return NOT_PRIME if number % value == 0
    end
    PRIME
  end

  private

  attr_reader :number

  def divisors
    unless @divisors
      @divisors = []

      (2..number).each do |value|
        break if value**2 > number

        @divisors << value
      end
    end
    @divisors
  end
end

class PrimalityValidatorBenchmark
  NUMBERS = [1_000_003, 100_000_003, 1_000_000_007]

  def call
    Benchmark.bm(20) do |b|
      NUMBERS.each do |number|
        b.report("number = #{number}") do
          PrimalityValidator.new(number).call
        end
      end
    end
  end
end

# PrimalityValidatorBenchmark.new.call
# number = 1000003       0.000000   0.000000   0.000000 (  0.000259)
# number = 100000003     0.000000   0.000000   0.000000 (  0.001120)
# number = 1000000007    0.010000   0.000000   0.010000 (  0.005401)
