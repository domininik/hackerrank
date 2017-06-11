# https://www.hackerrank.com/challenges/ctci-ransom-note

require 'test/unit'

class NoteValidatorTest < Test::Unit::TestCase
  def test_valid?
    assert_equal('Yes', NoteValidator.new(6, 4, 'give me one grand today night', 'give one grand today').valid?)
    assert_equal('No', NoteValidator.new(6, 5, 'two times three is not four', 'two times two is four').valid?)
  end
end

class NoteValidator
  attr_reader :magazine_words_count, :note_words_count, :magazine_text, :note_text

  def initialize(magazine_words_count, note_words_count, magazine_text, note_text)
    @magazine_text = magazine_text
    @note_text = note_text
  end

  def valid?
    magazine_word_couts = Hash.new(0)
    magazine_text.split.each { |word| magazine_word_couts[word] += 1 }

    note_text.split.each do |word|
      return 'No' if magazine_word_couts[word] < 1

      magazine_word_couts[word] -= 1
    end
    'Yes'
  end
end
