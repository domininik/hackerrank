# https://www.hackerrank.com/challenges/richie-rich

require 'test/unit'

class PalindromeCalculatorTest < Test::Unit::TestCase
  def test_call
    assert_equal(3993, PalindromeCalculator.new('3943', 4, 1).call)
    assert_equal(992299, PalindromeCalculator.new('092282', 6, 3).call)
    assert_equal(-1, PalindromeCalculator.new('0011', 4, 1).call)
    assert_equal(12921, PalindromeCalculator.new('12321', 5, 1).call)
    assert_equal(992299, PalindromeCalculator.new('932239', 6, 2).call)
    assert_equal(99399, PalindromeCalculator.new('11331', 5, 4).call)
  end
end

class PalindromeCalculator
  MAX_DIGIT = 9

  attr_reader :value, :size, :max_ops_count, :ops_count, :left_index, :right_index

  def initialize(value, size, max_ops_count)
    @value = value
    @size = size
    @max_ops_count = max_ops_count
    @ops_count = 0
    @left_index = 0
    @right_index = size - 1
  end

  def call
    make_palindrome
    maximize_palindrome
    palindrome_valid? ? palindrome : -1
  end

  private

  def make_palindrome
    while left_index <= right_index && ops_count < max_ops_count
      left_digit = digits[left_index]
      right_digit = digits[right_index]

      if left_digit != right_digit
        digit = [left_digit, right_digit].max
        digits[left_index] = digit
        digits[right_index] = digit
        @ops_count += 1
      end

      @left_index += 1
      @right_index -= 1
    end
  end

  def maximize_palindrome
    left_index = 0
    right_index = size - 1

    while left_index <= right_index && ops_count < max_ops_count
      if digits[left_index] != MAX_DIGIT
        @ops_count -= 1 if digits[left_index] != original_digits[left_index]
        @ops_count -= 1 if digits[right_index] != original_digits[right_index]

        if ops_count + 2 <= max_ops_count
          digits[left_index] = MAX_DIGIT
          digits[right_index] = MAX_DIGIT
          @ops_count += 2
        end
      end

      left_index += 1
      right_index -= 1
    end

    center_index = size / 2

    if ops_count < max_ops_count && digits[center_index] != MAX_DIGIT
      digits[center_index] = MAX_DIGIT
    end
  end

  def palindrome_valid?
    digits == digits.reverse
  end

  def palindrome
    @palindrome ||= digits.join.to_i
  end

  def digits
    @digits ||= value.chars.map(&:to_i)
  end

  def original_digits
    @original_digits ||= value.chars.map(&:to_i)
  end
end
