# https://www.hackerrank.com/challenges/append-and-delete

require 'test/unit'

class TextProcessorTest < Test::Unit::TestCase
  def test_call
    assert_equal('Yes', TextProcessor.new('hackerhappy', 'hackerrank', 9).call)
    assert_equal('Yes', TextProcessor.new('hackerhappy', 'hackerrank', 11).call)
    assert_equal('No', TextProcessor.new('hackerhappy', 'hackerrank', 10).call)

    assert_equal('Yes', TextProcessor.new('aba', 'aba', 0).call)
    assert_equal('Yes', TextProcessor.new('aba', 'aba', 7).call)
    assert_equal('Yes', TextProcessor.new('aba', 'aba', 10).call)

    assert_equal('No', TextProcessor.new('aba', 'baba', 6).call)
    assert_equal('Yes', TextProcessor.new('aba', 'baba', 7).call)
    assert_equal('Yes', TextProcessor.new('aba', 'baba', 8).call)

    assert_equal('Yes', TextProcessor.new('aba', 'abax', 1).call)
    assert_equal('No', TextProcessor.new('aba', 'abax', 2).call)
    assert_equal('Yes', TextProcessor.new('aba', 'abax', 3).call)
    assert_equal('No', TextProcessor.new('aba', 'abax', 4).call)
    assert_equal('Yes', TextProcessor.new('aba', 'abax', 5).call)
    assert_equal('No', TextProcessor.new('aba', 'abax', 6).call)
    assert_equal('Yes', TextProcessor.new('aba', 'abax', 7).call)

    assert_equal('Yes', TextProcessor.new('ab', 'abba', 2).call)
    assert_equal('No', TextProcessor.new('ab', 'abba', 3).call)
    assert_equal('Yes', TextProcessor.new('ab', 'abba', 4).call)
  end
end

class TextProcessor
  attr_reader :input, :output, :number_of_ops_required

  def initialize(input, output, number_of_ops_required)
    @input = input.split(//)
    @output = output.split(//)
    @number_of_ops_required = number_of_ops_required
  end

  def call
    return 'Yes' if input == output && conditions_for_equal_strings_met?

    other_conditions_met? ? 'Yes' : 'No'
  end

  private

  def input_size
    @input_size ||= input.size
  end

  def output_size
    @output_size ||= output.size
  end

  def conditions_for_equal_strings_met?
    return true if number_of_ops_required % 2 == 0
    return true if number_of_ops_required >= 2 * input_size
    false
  end

  def number_of_chars_to_remove
    @number_of_chars_to_remove ||= input_size - first_index_of_nonequal_char
  end

  def number_of_chars_to_append
    @number_of_chars_to_append ||= output_size - first_index_of_nonequal_char
  end

  def min_number_of_ops
    @min_number_of_ops ||= number_of_chars_to_remove + number_of_chars_to_append
  end

  def first_index_of_nonequal_char
    return @first_index_of_nonequal_char if @first_index_of_nonequal_char

    char_index = 0

    while input[char_index] && output[char_index] && input[char_index] == output[char_index]
      char_index += 1
    end

    @first_index_of_nonequal_char = char_index
  end

  def other_conditions_met?
    return true if number_of_ops_required == min_number_of_ops
    return true if number_of_ops_required >= input_size + output_size

    if number_of_ops_required > min_number_of_ops
      return true if min_number_of_ops % 2 == 0 && number_of_ops_required % 2 == 0
      return true if min_number_of_ops % 2 == 1 && number_of_ops_required % 2 == 1
      false
    else
      false
    end
  end
end
