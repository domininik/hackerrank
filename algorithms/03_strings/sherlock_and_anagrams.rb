# https://www.hackerrank.com/challenges/sherlock-and-anagrams

require 'test/unit'

class AnagramCalculatorTest < Test::Unit::TestCase
  def test_calculate
    assert_equal(0, AnagramCalculator.new('abcd').calculate)
    assert_equal(2, AnagramCalculator.new('abca').calculate)
    assert_equal(4, AnagramCalculator.new('abba').calculate)
    assert_equal(3, AnagramCalculator.new('ifailuhkqq').calculate)
    assert_equal(2, AnagramCalculator.new('hucpoltgty').calculate)
    assert_equal(2, AnagramCalculator.new('ovarjsnrbf').calculate)
    assert_equal(6, AnagramCalculator.new('pvmupwjjjf').calculate)
    assert_equal(3, AnagramCalculator.new('iwwhrlkpek').calculate)
  end
end

class AnagramCalculator
  MIN_SUBSTRING_SIZE = 1

  def initialize(string)
    @string = string
    @substrings = {}
    @result = 0
  end

  def calculate
    get_substrings
    calculate_number_of_anagrams
    result
  end

  private

  attr_reader :string, :substrings, :result

  def get_substrings
    (min_substring_size..max_substring_size).each do |substring_size|
      max_start_index = string_size - substring_size

      (0..max_start_index).each do |start_index|
        end_index = start_index + substring_size - 1
        substrings[substring_size] ||= Hash.new(0)
        substring = string[start_index..end_index]
        sorted_substring = substring.chars.sort.join
        substrings[substring_size][sorted_substring] += 1
      end
    end
  end

  def calculate_number_of_anagrams
    substrings.each do |substring_size, substring_counts|
      number_of_anagrams = substring_counts.values.map { |n| anagram_count_for(n) }.reduce(:+)
      @result += number_of_anagrams
    end
  end

  def min_substring_size
    MIN_SUBSTRING_SIZE
  end

  def max_substring_size
    @max_substring_size ||= string_size - 1
  end

  def string_size
    @string_size ||= string.size
  end

  def anagram_count_for(n)
    (n * (n - 1)) / 2
  end
end
