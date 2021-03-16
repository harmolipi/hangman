require_relative 'color'

REPLAY_PATTERN = /\b(?:y|n|load)\b/
GUESS_PATTERN = /\b[a-zA-Z]\b/
play_game = true
dictionary_words = File.readlines('5desk.txt').select { |word| word.strip.length.between?(5, 12) }

def game_loop(secret_word)
  guesses = []
  incorrect_guesses = 10
  while incorrect_guesses >= 0
    begin
      puts "Enter a letter, or type 'save' to save your progress: "
      guess = gets.chomp
      raise 'Invalid guess, please try again.' unless guess.match?(GUESS_PATTERN)

      raise 'You already guessed that letter!' if guesses.include?(guess)
    rescue StandardError => e
      puts e.to_s.red
      retry
    end
    guesses << guess
    incorrect_guesses -= 1
  end
end

puts 'Hangman Initialized'

while play_game
  secret_word = dictionary_words.sample
  puts 'Time for a new hangman game!'
  game_loop(secret_word)
  begin
    puts 'Would you like to play again? (y/n) '
    answer = gets.chomp
    raise unless answer.match?(REPLAY_PATTERN)
  rescue StandardError
    puts 'Invalid entry, try again.'.red
    retry
  end
  play_game = answer == 'y'
end

# _ _ _ _ _ _ _ _
#
# Letters guessed:
#
#Enter your guess (x guesses left): 
