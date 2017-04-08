# https://www.hackerrank.com/challenges/staircase

require 'test/unit'

class StaircaseTest < Test::Unit::TestCase
  def test_draw
    expected_result = "  #\n ##\n###"
    assert_equal(expected_result, Staircase.new(3).draw)
  end
end

class Staircase
  attr_reader :size, :levels

  SPACE_CHAR = ' '
  HASH_CHAR = '#'

  def initialize(size)
    @size = size
    @levels = []
  end

  def draw
    (1..size).each do |index|
      number_of_spaces = size - index
      number_of_hashes = index

      level = ''
      number_of_spaces.times { level << SPACE_CHAR }
      number_of_hashes.times { level << HASH_CHAR }
      @levels << level
    end

    levels.join("\n")
  end
end
