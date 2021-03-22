# frozen_string_literal: true

# Text input and display functions
class Text
  GUESS_PATTERN = /\b[a-zA-Z]\b|\bsave\b/.freeze

  def self.input_guess(guesses, incorrect_guesses, correct_guesses)
    begin
      print "Enter a letter, or type 'save' to save your progress: "
      guess = gets.chomp.downcase
      raise "Invalid guess, please try again.\n" unless guess.match?(GUESS_PATTERN)
      raise "You already guessed that letter!\n" if guesses.include?(guess.green) || guesses.include?(guess.magenta)
    rescue StandardError => e
      puts e.to_s.red
      Text.display(incorrect_guesses, guesses, correct_guesses)
      retry
    end
    guess
  end

  def self.display(incorrect_guesses, guesses, correct_guesses)
    puts "\n#{incorrect_guesses} incorrect guesses left.".blue
    puts ''
    puts Text.display_guesses(guesses).to_s
    puts ''
    puts Text.display_word(correct_guesses).to_s
    puts ''
  end

  def self.display_guesses(guesses)
    print guesses.join(' ')
  end

  def self.display_word(correct_guesses)
    progress = correct_guesses.map do |letter|
      letter.nil? ? '_' : letter
    end
    print progress.join(' ')
  end

  def self.ending(won, secret_word)
    if won
      "Well done, old chap! You've done it again!\n".green
    else
      "So sorry, old sport - you've failed! The word was '#{secret_word}'.\n".blue
    end
  end
end
