# https://www.hackerrank.com/challenges/ctci-making-anagrams

require 'test/unit'

class AnagramMakerTest < Test::Unit::TestCase
  def test_call
    assert_equal(4, AnagramMaker.new.call('cde', 'abc'))
    assert_equal(5, AnagramMaker.new.call('cd', 'abccdef'))
  end
end

class AnagramMaker
  def call(string_1, string_2)
    string_1_char_counts = Hash.new(0)
    string_1.chars.each { |char| string_1_char_counts[char] += 1 }

    string_2_char_counts = Hash.new(0)
    string_2.chars.each { |char| string_2_char_counts[char] += 1 }

    result = 0

    string_1_char_counts.each do |key, value|
      diff = (string_2_char_counts[key] - value).abs
      result += diff
      string_2_char_counts.delete(key)
    end

    string_2_char_counts.each do |key, value|
      diff = (string_1_char_counts[key] - value).abs
      result += diff
    end

    result
  end
end


