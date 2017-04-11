# https://www.hackerrank.com/challenges/the-time-in-words

require 'test/unit'

class TimeInWordsTest < Test::Unit::TestCase
  def test_call
    assert_equal("five o' clock", TimeInWords.new.call(5, 0))
    assert_equal("one minute past five", TimeInWords.new.call(5, 1))
    assert_equal("ten minutes past five", TimeInWords.new.call(5, 10))
    assert_equal("quarter past five", TimeInWords.new.call(5, 15))
    assert_equal("half past five", TimeInWords.new.call(5, 30))
    assert_equal("twenty minutes to six", TimeInWords.new.call(5, 40))
    assert_equal("quarter to six", TimeInWords.new.call(5, 45))
    assert_equal("thirteen minutes to six", TimeInWords.new.call(5, 47))
    assert_equal("twenty eight minutes past five", TimeInWords.new.call(5, 28))
    assert_equal("twenty seven minutes to six", TimeInWords.new.call(5, 33))
  end
end

class TimeInWords
  NUMBER_IN_WORDS = {
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
  }

  def call(hour, minutes)
    case minutes
    when 0
      hour_in_words = NUMBER_IN_WORDS[hour]
      "#{hour_in_words} o' clock"
    when 15
      hour_in_words = NUMBER_IN_WORDS[hour]
      "quarter past #{hour_in_words}"
    when 30
      hour_in_words = NUMBER_IN_WORDS[hour]
      "half past #{hour_in_words}"
    when 45
      hour_in_words = NUMBER_IN_WORDS[hour + 1]
      "quarter to #{hour_in_words}"
    else
      if minutes > 30
        minutes_in_words = NUMBER_IN_WORDS[60 - minutes] || (NUMBER_IN_WORDS[20] + ' ' + NUMBER_IN_WORDS[60 - minutes - 20])
        past_or_to = 'to'
        hour_in_words = NUMBER_IN_WORDS[hour + 1]
      else
        minutes_in_words = NUMBER_IN_WORDS[minutes] || (NUMBER_IN_WORDS[20] + ' ' + NUMBER_IN_WORDS[minutes - 20])
        past_or_to = 'past'
        hour_in_words = NUMBER_IN_WORDS[hour]
      end
      plural_suffix = (minutes > 1 ? 's' : '')

      "#{minutes_in_words} minute#{plural_suffix} #{past_or_to} #{hour_in_words}"
    end
  end
end




