# https://www.hackerrank.com/challenges/sherlock-and-valid-string

require 'test/unit'

class StringValidatorTest < Test::Unit::TestCase
  def test_valid?
    assert_equal('YES', StringValidator.new('aabbcc').valid?)
    assert_equal('NO', StringValidator.new('baacdd').valid?)
    assert_equal('YES', StringValidator.new('aabbccc').valid?)
    assert_equal('YES', StringValidator.new('aabbc').valid?)
    assert_equal('NO', StringValidator.new('abcccc').valid?)
    assert_equal('NO', StringValidator.new('aabbcd').valid?)
  end
end

class StringValidator
  def initialize(string)
    @string = string
    @chars = Hash.new(0)
  end

  def valid?
    count_chars
    validate
  end

  private

  attr_reader :string, :chars

  def count_chars
    string.chars.each { |char| chars[char] += 1 } if chars.empty?
  end

  def validate
    if (
        uniq_values.count == 2 &&
        (uniq_values.reduce(:-).abs == 1 || (values[0] == 1 && values[1] != 1)) &&
        (values[0..-2].uniq.count == 1 || values[1..-1].uniq.count == 1)
       ) || uniq_values.count == 1
      'YES'
    else
      'NO'
    end
  end

  def values
    @values ||= chars.values.sort
  end

  def uniq_values
    @uniq_values ||= values.uniq
  end
end
