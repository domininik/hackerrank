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
  def initialize(string_size, string)
    @string_size = string_size
    @string = string
    @start_index = 0
    @end_index = 0
    @result = Float::INFINITY
  end

  def call
    while anything_left? do
      if !ready_to_replace?
        take_more
      else
        update_result
        take_less
      end
    end
    result
  end

  private

  attr_reader :string_size, :string, :start_index, :end_index, :result

  def anything_left?
    start_index < string_size && end_index < string_size
  end

  def ready_to_replace?
    left_chars_frequencies.all? { |char, frequency| frequency <= required_char_frequency }
  end

  def take_more
    last_char = string[end_index]
    left_chars_frequencies[last_char] -= 1
    @end_index += 1
  end

  def take_less
    first_char = string[start_index]
    left_chars_frequencies[first_char] += 1
    @start_index += 1
  end

  def update_result
    new_result = end_index - start_index
    @result = [result, new_result].min
  end

  def left_chars_frequencies
    unless @left_chars_frequencies
      @left_chars_frequencies = Hash.new(0)
      string.chars.each { |char| @left_chars_frequencies[char] += 1 }
    end
    @left_chars_frequencies
  end

  def required_char_frequency
    @required_char_frequency ||= string_size / 4
  end
end

class GeneReplacerBenchmark
  SET_SIZES = [100, 1_000, 10_000]

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
# size = 100             0.000000   0.000000   0.000000 (  0.000272)
# size = 1000            0.000000   0.000000   0.000000 (  0.001736)
# size = 10000           0.030000   0.000000   0.030000 (  0.031434)
