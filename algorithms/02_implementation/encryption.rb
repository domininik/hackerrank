# https://www.hackerrank.com/challenges/encryption

require 'test/unit'

class EncryptorTest < Test::Unit::TestCase
  def test_encode
    assert_equal('hae and via ecy', Encryptor.new('haveaniceday').encode)
    assert_equal('fto ehg ee dd', Encryptor.new('feedthedog').encode)
    assert_equal('clu hlt io', Encryptor.new('chillout').encode)
    assert_equal(
      'imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn sseoau',
      Encryptor.new('ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots').encode
    )
  end
end

class Encryptor
  attr_reader :string

  def initialize(string)
    @string = string
  end

  def encode
    string_size = string.size
    root = Math.sqrt(string_size)
    number_of_columns = root.ceil
    number_of_rows = (string_size / number_of_columns.to_f).ceil

    array = string.split(//)
    grid = []
    index = 0

    number_of_rows.times do
      grid << array.slice(index, number_of_columns)
      index += number_of_columns
    end

    result = []

    (0..(number_of_columns - 1)).each do |column_index|
      (0..(number_of_rows - 1)).each do |row_index|
        result[column_index] = [] unless result[column_index]
        result[column_index][row_index] = grid[row_index][column_index]
      end
    end

    result.map { |row| row.join }.join(' ')
  end
end
