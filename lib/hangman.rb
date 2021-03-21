require_relative 'color'
require_relative 'game'
require 'pry'
require 'msgpack'

REPLAY_PATTERN = /\b(?:y|n|load)\b/
play_game = true
dictionary_words = File.readlines('5desk.txt').select { |word| word.strip.length.between?(5, 12) }

# def reset(secret_word)
#   @correct_guesses = Array.new(secret_word.length, '_')
#   @progress = []
#   @secret_array = secret_word.split('')
#   @incorrect_guesses = 10
# end

# def game_loop(secret_word)
#   reset(secret_word)
#   guesses = []
#   puts secret_word
#   display(guesses)
#   while @incorrect_guesses > 0
#     guess = input_guess(guesses)
#     # guesses << (correct?(guess) ? guess.green : guess.gray)
#     if correct?(guess)
#       guesses << guess.green
#       add_guesses(guess)
#     else
#       guesses << guess.magenta
#       @incorrect_guesses -= 1
#     end
#     display(guesses)
#     won = won?(secret_word)
#     break if won
#     # guesses << input_guess(guesses)
#   end

#   ending(won)
  
# end

# def input_guess(guesses)
#   begin
#     print "Enter a letter, or type 'save' to save your progress: "
#     guess = gets.chomp.downcase
#     raise 'Invalid guess, please try again.' unless guess.match?(GUESS_PATTERN)
#     raise 'You already guessed that letter!' if guesses.include?(guess.green) || guesses.include?(guess.magenta)
#   rescue StandardError => e
#     puts e.to_s.red
#     display(guesses)
#     retry
#   end
#   guess
# end

# def display(guesses)
#   puts "#{@incorrect_guesses} incorrect guesses left."
#   puts ''
#   puts "#{display_guesses(guesses)}"
#   puts ''
#   puts "#{display_word}\n"
#   puts ''
# end

# def display_word
#   @progress = @correct_guesses.map do |letter|
#     letter.nil? ? '_' : letter
#   end
#   print @progress.join(' ')
# end

# def display_guesses(guesses)
#   print guesses.join(' ')
# end

# def add_guesses(guess)
#   @secret_array.each_with_index do |letter, index|
#     if letter == guess
#       @correct_guesses[index] = guess
#       @secret_array[index] = nil
#     end
#   end
# end

# def correct?(guess)
#   @secret_array.include?(guess)
# end

# def won?(secret_word)
#     # binding.pry
#     @correct_guesses.eql?(secret_word.split(''))
# end

# def ending(won)
#   puts won ? "Well done, old chap! You've done it again!\n".green : "So sorry, old sport - you've failed!\n".blue
# end

puts 'Hangman Initialized'

while play_game
  secret_word = dictionary_words.sample.strip.downcase
  puts "\nTime for a new hangman game!"
  Game.game_loop(secret_word)
  begin
    print 'Would you like to play again? (y/n) '
    answer = gets.chomp
    raise unless answer.match?(REPLAY_PATTERN)
  rescue StandardError
    puts 'Invalid entry, try again.'.red
    retry
  end
  play_game = answer == 'y'
end

# while play_game
#   secret_word = dictionary_words.sample.strip.downcase
#   puts "\nTime for a new hangman game!"
#   game_loop(secret_word)
#   begin
#     print 'Would you like to play again? (y/n) '
#     answer = gets.chomp
#     raise unless answer.match?(REPLAY_PATTERN)
#   rescue StandardError
#     puts 'Invalid entry, try again.'.red
#     retry
#   end
#   play_game = answer == 'y'
# end
