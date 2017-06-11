# https://www.hackerrank.com/challenges/bear-and-steady-gene

require 'test/unit'
require 'benchmark'

class GeneReplacerTest < Test::Unit::TestCase
  def test_call
    assert_equal(5, GeneReplacer.new(8, 'GAAATAAA').call)
    assert_equal(5, GeneReplacer.new(40, 'TGATGCCGTCCCCTCAACTTGAGTGCTCCTAATGCGTTGC').call)
  end
end

class GeneReplacer
  LETTERS = %w{ A C T G }

  def initialize(string_size, string)
    @string_size = string_size
    @string = string
    @diffs = Hash.new(0)
    @global_letter_counts = {}
    @substring_size = 0
  end

  def call
    build_diffs

    return 0 if diffs.empty?

    (min_possible_substring_size..string_size).each do |substring_size|
      start_index_max = string_size - substring_size - 1

      (0..start_index_max).each do |start_index|
        end_index = start_index + substring_size - 1

        return substring_size if range_valid?(start_index, end_index)
      end
    end
  end

  private

  attr_reader :string_size, :string, :diffs, :global_letter_counts, :substring_size

  def build_diffs
    required_substring_size = string_size / 4
    string_letters = string.chars
    letter_counts = Hash.new(0)
    string_letters.each { |letter| letter_counts[letter] += 1 }

    LETTERS.each do |letter|
      diff = letter_counts[letter] - required_substring_size
      diffs[letter] = diff if diff > 0
    end
  end

  def key_for(start_index, end_index)
    "#{start_index}-#{end_index}"
  end

  def min_possible_substring_size
    @min_possible_substring_size ||= diffs.values.reduce(:+)
  end

  def range_valid?(start_index, end_index)
    key = "#{start_index}-#{end_index}"
    build_letter_count_for(start_index, end_index) unless global_letter_counts[key]

    letter_counts = global_letter_counts[key]
    diffs.all? { |letter, diff| letter_counts[letter] >= diff }
  end

  def build_letter_count_for(start_index, end_index)
    previous_end_index_key = key_for(start_index, end_index - 1)
    previous_start_index_key = key_for(start_index - 1, end_index)

    if prev_letter_counts = (global_letter_counts[previous_end_index_key] || global_letter_counts[previous_start_index_key])
      letter_counts = prev_letter_counts.dup

      if global_letter_counts[previous_end_index_key]
        last_letter = string[end_index]
        last_letter_count = letter_counts[last_letter]

        if last_letter_count
          letter_counts[last_letter] += 1
        else
          letter_counts[last_letter] = 1
        end
      elsif global_letter_counts[previous_start_index_key]
        first_letter = string[start_index - 1]
        first_letter_count = letter_counts[first_letter]

        if first_letter_count
          letter_counts[first_letter] -= 1
        else
          letter_counts[first_letter] = 0
        end
      end
    else
      slice = string.slice(start_index..end_index)
      letter_counts = Hash.new(0)
      slice.chars.each { |letter| letter_counts[letter] += 1 }
    end
    global_letter_counts[key_for(start_index, end_index)] = letter_counts
  end
end

class GeneReplacerBenchmark
  SET_SIZES = [100, 200, 500, 1000, 1500, 2000]

  TEST_STRING = 'ACAAAAATAAACAAAAACAAAAAAAAAATAAATACAATAAAAAAAAAAAATGAAATACAACAACAAATAAAATAAAAACGACTAAAAAATAAAAAAAAAAAAAAAAAGAGTACTAAAAAAAAAAAAAAAAAATAAAAAAAAAAAAAACACAATCAAAATAAACAAAAAAAAAAAAACCAAAATAATCAACAAAAAAAAAAAAAACAAAAACAACAACAAACAAAAAAAAACACAAACAAAAAAAAAAAAAAAACAAAACAAACAAAAAAAAAAAAACAAAAAAACAAAAAAAAAAAAAAAAACAAAAAAAAAAATAAAAAAAAAAAAAAAAAAAAAACAAACAAAAAAAAAAAATACAAAAAGCTATAAAAAAAAAAAAATTAAAAAACAAAAAAAAATAAAAAAAAAAAAAAAAAAAAAAAATAAAAAAAAAAAAAAAAAAAAAATAAAAAAAAAAAAAAAAAAGAAAAACAAAAAAAAAAAAAAAAACAACCAAAAAACAAAAAAAAACTAAAAAAAAAAAAAAAAAAAAAAAAAAATAACAAAAAACACAAAAAAAAAAAAGAAAGAAAAAAAACACAAAAAAAAACAAACAAAAAAAAAAAAAAAAAAAGAAAACAAAAAAACAAAAAAAACAAAAAAAAAACAAAAATTGGACAAAAAAAAACAAAAAAAAAAAACAAAAAAAGTAAAACAAATAAAAAAACAAAAAAAACAAAAAAAAAAAAAAAAAACAAAAAAGAAACAAAAAACAAAAAAAAATAACAAAACCAAAAAACAAATAAAAAACAAAAAAAATAACACAAAAAAAAAAAGAAACAAAAAAAAAAAAAAAAAAAAAAATTATAAAAAAAAAAAAAAAACAAAAAAAAAAAAAACAAAAAAAAAAGGAAAAAAAAAAAAAAAAAAAAAAAAAAATAACTAAACAAAAAAAAACAAACAAAAAATCAAAAAAAAAAAAGAAAAAAGAATAAGCAACAAAAACACAAAAAAAAAAAAAAAAAAAAAAAACATAAACAATAATAAAAAAAAAACAAAAAAAACAAAAGAACAACAAAAAACAAAACTAAACAAATAAAAAAAAAAAAACAAAAACTACAAAAAAAAAAAGAAAAAAAAAGAAAAAAAAACAAATAAAAGAAAAAAAAAAAAAAAAAAAACACAAAAAAAAAAATAAAAAAAAAAAAAAAAACAAAATAAACAAAAACAAAGAAAAAAACAAACAAAAAAAAAAAACAAAAAACTAAAAACAAAAAAAAAACAAAACACAAAAAAAAAAAAAAATAAAAAAAAAACAAAAAAACAAAAAGGAAAAAAAAAAAAGAACAAAAAAAAAAACAACAGAAAAAAGAAAAGAAAAAAAAAAAAAGACCACAAAATAAAAAAAAACAACAAACAAAAAAAAACAAAACAAAAAAACGAACAAAAAAAACAAAAACAAAAAAAAAAAAAAAAAAAAAAAGGCAAAAACAAAAAAAACAAAACAAAACAAAAAAACAAAAAAAAATTAAGATAAAGAACAAAAAAAGAAGAGAAAAAATTAACAAAAAAAAAAAAATAAAAAATACAAAAAGAAATAAAAAATACAACACACAACAAAAACGAAAAAAAAAAAAAAAACACAAAATAGAAAAAAAAAAAAAACAAAAAAAAAAAAAAGAAAAAAACAAAAAAAAAAAAATAAAAAAAAACGACACAGAAACAAAAAATAACAAAAAAAAAAAAAATAAAAAAAAAACAAAAAAAAAACAAAAAATAAAAAAAAAAACAAACAAAAAAAAAAAAAAAATAAAAAAAAAAAAAGCAAAACATAAACAAGAAAAAAAAAAAAAGTACAAATAACAAAACAAAAAAGACACTAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAGAAAAAAAACCACAAAACAAAAAAATAAAGCAAAAAAAAAAAAAAAAAAAAAAAAAAAATAAATGAAAAAAAAAAGAAAACCAAAAAAATAAAAGA'

  def call
    Benchmark.bm(20) do |b|
      SET_SIZES.each do |size|
        b.report("size = #{size}") do
          string = TEST_STRING.slice(0..(size - 1))
          GeneReplacer.new(size, string).call
        end
      end
    end
  end
end

# GeneReplacerBenchmark.new.call
#                            user     system      total        real
# size = 100             0.010000   0.000000   0.010000 (  0.003107)
# size = 200             0.010000   0.010000   0.020000 (  0.012646)
# size = 500             0.070000   0.000000   0.070000 (  0.069262)
# size = 1000            0.240000   0.000000   0.240000 (  0.250937)
# size = 1500            0.600000   0.010000   0.610000 (  0.607553)
# size = 2000            1.200000   0.010000   1.210000 (  1.208044)
