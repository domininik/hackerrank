# https://www.hackerrank.com/challenges/diagonal-difference

require 'test/unit'

class DiagonalDifferenceCalculatorTest < Test::Unit::TestCase
  def test_call
    assert_equal(15, DiagonalDifferenceCalculator.new(3, [[11, 2, 4], [4, 5, 6], [10, 8, -12]]).call)
  end
end

class DiagonalDifferenceCalculator
  attr_reader :matrix_size, :matrix

  def initialize(matrix_size, matrix)
    @matrix_size = matrix_size
    @matrix = matrix
  end

  def call
    diagonal_left = []

    (0..(matrix_size - 1)).each do |index|
      diagonal_left << matrix[index][index]
    end

    diagonal_right = []

    (0..(matrix_size - 1)).each do |row_index|
      column_index = (matrix_size - 1) - row_index
      diagonal_right << matrix[row_index][column_index]
    end

    diagonal_left_sum = diagonal_left.reduce(:+)
    diagonal_right_sum = diagonal_right.reduce(:+)

    (diagonal_left_sum - diagonal_right_sum).abs
  end
end
