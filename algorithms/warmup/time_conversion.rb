# https://www.hackerrank.com/challenges/time-conversion

require 'test/unit'

class TimeConverterTest < Test::Unit::TestCase
  def test_call
    assert_equal('19:05:45', TimeConverter.new.call('07:05:45PM'))

    assert_equal('12:00:00', TimeConverter.new.call('12:00:00PM'))
    assert_equal('12:05:00', TimeConverter.new.call('12:05:00PM'))
    assert_equal('13:05:20', TimeConverter.new.call('01:05:20PM'))

    assert_equal('00:00:00', TimeConverter.new.call('12:00:00AM'))
    assert_equal('00:05:00', TimeConverter.new.call('12:05:00AM'))
    assert_equal('01:05:20', TimeConverter.new.call('01:05:20AM'))
  end
end

class TimeConverter
  def call(timestamp)
    period = timestamp.slice!(-2..-1)

    time_parts = timestamp.split(':')

    hours_part = time_parts[0].to_i
    minutes_part = time_parts[1]
    seconds_part = time_parts[2]

    if (period == 'PM' && hours_part != 12) || (period == 'AM' && hours_part == 12)
      hours_part += 12
    end

    hours_part = "0#{hours_part}" if hours_part < 10
    hours_part = '00' if hours_part == 24

    "#{hours_part}:#{minutes_part}:#{seconds_part}"
  end
end

