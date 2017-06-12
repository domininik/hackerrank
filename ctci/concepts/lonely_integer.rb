# https://www.hackerrank.com/challenges/ctci-lonely-integer

require 'test/unit'
require 'benchmark'

class LonelyIntegerFinderTest < Test::Unit::TestCase
  def test_call
    assert_equal(1, LonelyIntegerFinder.new.call(1, [1]))
    assert_equal(2, LonelyIntegerFinder.new.call(3, [1, 1, 2]))
    assert_equal(2, LonelyIntegerFinder.new.call(5, [0, 0, 1, 2, 1]))
  end
end

class LonelyIntegerFinder
  def call(size, array)
    array.reduce(:^)
  end
end

class LonelyIntegerFinderBenchmark
  SET_SIZES = [1_000, 10_000, 100_000, 1_000_000]

  def call
    Benchmark.bm(20) do |b|
      SET_SIZES.each do |size|
        b.report("size = #{size}") do
          array = Array.new(size) { rand(size) }
          LonelyIntegerFinder.new.call(size, array)
        end
      end
    end
  end
end

# LonelyIntegerFinderBenchmark.new.call
#                            user     system      total        real
# size = 1000            0.000000   0.000000   0.000000 (  0.000244)
# size = 10000           0.010000   0.000000   0.010000 (  0.002335)
# size = 100000          0.020000   0.000000   0.020000 (  0.022727)
# size = 1000000         0.230000   0.010000   0.240000 (  0.231683)
