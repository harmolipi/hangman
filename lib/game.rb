# TODO: write the game save load method
# list save files with this:
# saves = Dir.entries('./saves').select { |f| File.file?("./saves/#{f}") }

class Game
  GUESS_PATTERN = /\b[a-zA-Z]\b|\bsave\b/
  @secret_array = []
  @correct_guesses = []
  @progress = []
  @incorrect_guesses = 10

  def self.reset(secret_word)
    @correct_guesses = Array.new(secret_word.length, '_')
    @progress = []
    @secret_array = secret_word.split('')
    @incorrect_guesses = 10
  end

  def self.save
    save = {
      'secret_array' => @secret_array,
      'progress' => @progress
    }.to_msgpack
    print 'Please enter a name for your save: '
    save_name = gets.chomp
    save_file = File.open("./saves/#{save_name}.save", 'w')
    save_file.print save
    save_file.close
    exit
  end

  def self.load
    puts 'Choose your save file:'



  end

  def self.game_loop(secret_word)
    Game.reset(secret_word)
    guesses = []
    puts secret_word
    Game.display(guesses)
    while @incorrect_guesses > 0
      guess = Game.input_guess(guesses)
      # guesses << (correct?(guess) ? guess.green : guess.gray)
      if guess == 'save'
        Game.save
      elsif correct?(guess)
        guesses << guess.green
        Game.add_guesses(guess)
      else
        guesses << guess.magenta
        @incorrect_guesses -= 1
      end
      Game.display(guesses)
      won = Game.won?(secret_word)
      break if won
      # guesses << input_guess(guesses)
    end
    puts Game.ending(won, secret_word)
  end

  def self.input_guess(guesses)
    begin
      print "Enter a letter, or type 'save' to save your progress: "
      guess = gets.chomp.downcase
      raise 'Invalid guess, please try again.' unless guess.match?(GUESS_PATTERN)
      raise 'You already guessed that letter!' if guesses.include?(guess.green) || guesses.include?(guess.magenta)
    rescue StandardError => e
      puts e.to_s.red
      Game.display(guesses)
      retry
    end
    guess
  end

  def self.display(guesses)
    puts "#{@incorrect_guesses} incorrect guesses left."
    puts ''
    puts "#{Game.display_guesses(guesses)}"
    puts ''
    puts "#{Game.display_word}\n"
    puts ''
  end

  def self.display_word
    @progress = @correct_guesses.map do |letter|
      letter.nil? ? '_' : letter
    end
    print @progress.join(' ')
  end

  def self.display_guesses(guesses)
    print guesses.join(' ')
  end

  def self.add_guesses(guess)
    @secret_array.each_with_index do |letter, index|
      if letter == guess
        @correct_guesses[index] = guess
        @secret_array[index] = nil
      end
    end
  end

  def self.correct?(guess)
    @secret_array.include?(guess)
  end

  def self.won?(secret_word)
    # binding.pry
    @correct_guesses.eql?(secret_word.split(''))
  end

  def self.ending(won, secret_word)
    if won
      "Well done, old chap! You've done it again!\n".green
    else
      "So sorry, old sport - you've failed! The word was '#{secret_word}'.\n".blue
    end
  end
end
