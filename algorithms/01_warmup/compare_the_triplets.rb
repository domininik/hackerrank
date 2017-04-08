# https://www.hackerrank.com/challenges/compare-the-triplets

require 'test/unit'

class PointsCalculatorTest < Test::Unit::TestCase
  def test_call
    assert_equal('1 1', PointsCalculator.new([5, 6, 7], [3, 6, 10]).call)
  end
end

class PointsCalculator
  attr_reader :user_a_points, :user_b_points, :user_a_result, :user_b_result, :number_of_rounds

  def initialize(user_a_points, user_b_points)
    @user_a_points = user_a_points
    @user_b_points = user_b_points
    @user_a_result = 0
    @user_b_result = 0
    @number_of_rounds = user_a_points.size
  end

  def call
    number_of_rounds.times do |round|
      index = round - 1
      if user_a_points[index] > user_b_points[index]
        @user_a_result += 1
      elsif user_b_points[index] > user_a_points[index]
        @user_b_result += 1
      end
    end

    "#{user_a_result} #{user_b_result}"
  end
end
