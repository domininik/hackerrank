# https://www.hackerrank.com/challenges/ctci-array-left-rotation

require 'test/unit'

class ArrayRotatorTest < Test::Unit::TestCase
  def test_call
    assert_equal('2 3 4 5 1', ArrayRotator.new(5, 1, [1, 2, 3, 4, 5]).call)
    assert_equal('5 1 2 3 4', ArrayRotator.new(5, 4, [1, 2, 3, 4, 5]).call)
    assert_equal('6 8 10 2 4', ArrayRotator.new(5, 12, [2, 4, 6, 8, 10]).call)
  end
end

class ArrayRotator
  attr_reader :array_size, :number_of_operations, :array

  def initialize(array_size, number_of_operations, array)
    @array_size = array_size
    @number_of_operations = number_of_operations
    @array = array
  end

  def call
    array.dup.each_with_index do |ele, index|
      new_index = index - (number_of_operations % array_size)
      array[new_index] = ele
    end

    array.join(' ')
  end
end
