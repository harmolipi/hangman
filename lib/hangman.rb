# frozen_string_literal: true

require_relative 'color'
require_relative 'game'
require_relative 'text'
require_relative 'logic'
require 'msgpack'

REPLAY_PATTERN = /\b(?:y|n|load)\b/.freeze
NEW_GAME_PATTERN = /\b(?:1|2)\b/.freeze
ERROR = 'Invalid entry, try again.'.red
play_game = true
dictionary_words = File.readlines('5desk.txt').select { |word| word.strip.length.between?(5, 12) }

puts 'Hangman Initialized'

while play_game
  secret_word = dictionary_words.sample.strip.downcase
  puts "\nTime for a new hangman game!"
  begin
    print "\nEnter 1 to start a new game, or 2 to load a previous save: "
    new_game = gets.chomp
    raise unless new_game.match?(NEW_GAME_PATTERN)
  rescue StandardError
    puts ERROR
    retry
  end
  if new_game == '1'
    Game.game_loop(secret_word, false)
  else
    Game.load(secret_word)
  end
  begin
    print 'Would you like to play again? (y/n) '
    answer = gets.chomp
    raise unless answer.match?(REPLAY_PATTERN)
  rescue StandardError
    puts ERROR
    retry
  end
  play_game = answer == 'y'
end
