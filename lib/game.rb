# frozen_string_literal: true

# main game functions
class Game
  @secret_array = []
  @correct_guesses = []
  @incorrect_guesses = 10
  @guesses = []

  def self.reset(secret_word)
    @correct_guesses = Array.new(secret_word.length, '_')
    @secret_array = secret_word.split('')
    @incorrect_guesses = 10
    @guesses = []
  end

  def self.load_variables(save_variables)
    @secret_array = save_variables['secret_array']
    @correct_guesses = save_variables['correct_guesses']
    @incorrect_guesses = save_variables['incorrect_guesses']
    @guesses = save_variables['guesses']
  end

  def self.save(secret_word)
    save = {
      'secret_word' => secret_word,
      'secret_array' => @secret_array,
      'correct_guesses' => @correct_guesses,
      'progress' => @progress,
      'incorrect_guesses' => @incorrect_guesses,
      'guesses' => @guesses
    }.to_msgpack
    print 'Please enter a name for your save: '
    save_name = gets.chomp
    save_file = File.open("./saves/#{save_name}", 'w')
    save_file.print save
    save_file.close
    exit
  end

  def self.load(secret_word)
    saves = Dir.entries('./saves').select { |f| File.file?("./saves/#{f}") }
    if saves.empty?
      puts "Sorry, no game saves available. Starting a new game...\n".green
      Game.game_loop(secret_word, false)
      return nil
    else
      puts 'Choose your save file:'
      saves.each { |f| puts f.yellow }
    end
    begin
      print "\nWhich would you like to load? "
      load_save = gets.chomp
      raise unless saves.include?(load_save)
    rescue StandardError
      puts 'Invalid entry, please try again.'.red
      retry
    end
    load_file = File.open("./saves/#{load_save}")
    save_variables = MessagePack.unpack(load_file)
    Game.load_variables(save_variables)
    Game.game_loop(save_variables['secret_word'], true)
  end

  def self.game_loop(secret_word, loading)
    Game.reset(secret_word) unless loading
    Text.display(@incorrect_guesses, @guesses, @correct_guesses)
    while @incorrect_guesses.positive?
      guess = Text.input_guess(@guesses, @incorrect_guesses, @correct_guesses)
      if guess == 'save'
        Game.save(secret_word)
      elsif Logic.correct?(@secret_array, guess)
        @guesses << guess.green
        Game.add_guesses(guess)
      else
        @guesses << guess.magenta
        @incorrect_guesses -= 1
      end
      Text.display(@incorrect_guesses, @guesses, @correct_guesses)
      won = Logic.won?(@correct_guesses, secret_word)
      break if won
    end
    puts Text.ending(won, secret_word)
  end

  def self.add_guesses(guess)
    @secret_array.each_with_index do |letter, index|
      if letter == guess
        @correct_guesses[index] = guess
        @secret_array[index] = nil
      end
    end
  end
end
