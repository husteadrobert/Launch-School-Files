class Log
  attr_reader :human_history, :computer_history

  def initialize
    @human_history = []
    @computer_history = []
  end

  def count(element)
    @human_history.count(element)
  end

  def update(human_move, computer_move)
    @human_history << human_move.value
    @computer_history << computer_move.value
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze

  WINNING_COMBINATION = {
    'rock' => %w(scissors lizard),
    'paper' => %w(spock rock),
    'scissors' => %w(lizard paper),
    'spock' => %w(scissors rock),
    'lizard' => %w(spock paper)
  }.freeze

  LOSING_COMBINATION = {
    'rock' => %w(spock paper),
    'paper' => %w(scissors lizard),
    'scissors' => %w(spock rock),
    'spock' => %w(lizard paper),
    'lizard' => %w(rock scissors)
  }.freeze

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNING_COMBINATION[@value].include?(other_move.value)
  end

  def <(other_move)
    LOSING_COMBINATION[@value].include?(other_move.value)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    system('clear')
    n = ""
    loop do
      puts "Please input a name:"
      n = gets.chomp
      break unless n.strip.empty?
      puts "Invalid input, try again."
    end
    self.name = n.strip
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, spock or lizard:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def winning_percentages(history)
    winning_symbols = find_winning_symbols(history)
    percentage_hash = find_win_percent(winning_symbols, history)
    percentage_hash
  end

  def random(max_num)
    (1..max_num).to_a.sample
  end

  def sample_of_best(hash)
    maximum = hash.max_by { |_, v| v }
    array = []
    hash.each do |k, v|
      if v == maximum.last
        array << k
      end
    end
    array.sample
  end

  private

  def find_winning_symbols(history)
    total_games = history.computer_history.length
    winning_symbol = []
    index = 0
    while index < total_games
      computer_past_move = Move.new(history.computer_history[index])
      human_past_move = Move.new(history.human_history[index])
      if computer_past_move > human_past_move
        winning_symbol << history.computer_history[index]
      end
      index += 1
    end
    winning_symbol
  end

  def find_win_percent(winning_symbols, history)
    total_games = history.computer_history.length
    hash = Hash.new(0)
    Move::VALUES.each do |symbol|
      hash[symbol] = winning_symbols.count(symbol)
    end
    hash.each do |key, value|
      hash[key] = if value.positive?
                    value.to_f / total_games
                  else
                    0
                  end
    end
    hash
  end
end

class Deepblue < Computer
  def set_name
    self.name = 'DeepBlue'
  end

  # DeepBlue selects by random if there is no history.  Otherwise,
  # he calculates the winning percentage of each symbol.  He prefers
  # what he calculates as the highest rated symbol and will chose it
  # with 70% frequency.  Otherwise, he chooses at random.
  def choose(history)
    if history.computer_history.length.zero?
      self.move = Move.new(Move::VALUES.sample)
    else
      hash = winning_percentages(history)
      rand = random(10)
      self.move = Move.new(sample_of_best(hash)) if rand < 8
      self.move = Move.new(Move::VALUES.sample) if rand >= 8
    end
    move
  end

  def taunt
    rand = random(2)
    if rand == 1
      to_say = ""
      to_say << "Deep Blue says, "
      to_say << "\"I'm the smartest computer ever built. Just give up.\" "
      puts to_say
    end
  end
end

class R2D2 < Computer
  def set_name
    self.name = 'R2D2'
  end

  # R2D2 selects at pure random.
  def choose(*)
    self.move = Move.new(Move::VALUES.sample)
  end

  def taunt
    rand = random(2)
    puts "R2D2 says, \"Beep Boop Whizzzzz!\" " if rand == 1
  end
end

class Number5 < Computer
  def set_name
    self.name = "Johnny Number 5"
  end

  # Johnny #5 doesn't want to lose, but he doesn't want to win.
  # He just wants to stay alive.  So he chooses what he thinks
  # is most likely to tie by looking at the frequency of what's
  # been thrown so far.
  def choose(history)
    hash = {}
    Move::VALUES.each do |move|
      hash[move] = history.count(move)
    end
    self.move = Move.new(sample_of_best(hash))
  end

  def taunt
    rand = random(2)
    puts "Johnny says, \"Do not dissasemble Johnny Number 5!\" " if rand == 1
  end
end

class Hal < Computer
  def initialize(human_name)
    @human_name = human_name
    set_name
  end

  def set_name
    self.name = "Hal"
  end

  # Hal wants to win but he's always just a step behind.  He
  # checks the last move by the player and selects at random
  # one of the two winning solutions.  He selects at complete
  # random if there is no history.
  def choose(history)
    current_history = history.human_history
    return self.move = Move.new(Move::VALUES.sample) if current_history.empty?
    last_move = current_history.last
    possible_winning_moves = Move::LOSING_COMBINATION[last_move]
    self.move = Move.new(possible_winning_moves.sample)
  end

  def taunt
    rand = random(2)
    puts "Hal says, \"I can't let you do that, #{@human_name}.\" " if rand == 1
  end
end

class RPSGame
  MAX_SCORE = 10

  attr_accessor :human_score, :computer_score
  attr_reader :human, :computer, :history

  def initialize
    @human = Human.new
    @computer = random_opponent
    @history = Log.new
  end

  def random_opponent
    rand = (1..4).to_a.sample
    return R2D2.new if rand == 1
    return Number5.new if rand == 2
    return Hal.new(human.name) if rand == 3
    return Deepblue.new if rand == 4
  end

  def display_welcome_message
    to_say = ''
    to_say << "Welcome to Rock, Paper, Scissors, Spock, Lizard! "
    to_say << "First to #{MAX_SCORE} wins!"
    puts to_say
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts"#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer
      puts "Invalid choice, please input y or n."
    end
    return false if answer.casecmp('n').zero?
    return true if answer.casecmp('y').zero?
  end

  def initialize_score
    @human_score = 0
    @computer_score = 0
  end

  def at_max_score?
    (@human_score == MAX_SCORE) || (@computer_score == MAX_SCORE)
  end

  def display_overall_winner
    if human_score == MAX_SCORE
      puts "#{human.name} is the winner!"
    else
      puts "#{computer.name} is the winner!"
    end
  end

  def update_score
    if human.move > computer.move
      @human_score += 1
    elsif human.move < computer.move
      @computer_score += 1
      @computer.taunt
    end
  end

  def display_score
    puts "Current Score:"
    puts "#{human.name}: #{@human_score}  #{computer.name}: #{computer_score}"
  end

  def update_history
    @history.update(human.move, computer.move)
  end

  def display_opponent
    puts "You're facing off against #{computer.name}. Good luck!"
  end

  def single_game
    loop do
      human.choose
      computer.choose(@history)
      display_moves
      update_history
      display_winner
      update_score
      display_score
      break if at_max_score?
    end
  end

  def play
    loop do
      system('clear')
      initialize_score
      display_welcome_message
      display_opponent
      single_game
      display_overall_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
