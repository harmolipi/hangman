# frozen_string_literal: true

# Simple logic functions
class Logic
  def self.correct?(secret_array, guess)
    secret_array.include?(guess)
  end

  def self.won?(correct_guesses, secret_word)
    correct_guesses.eql?(secret_word.split(''))
  end
end
