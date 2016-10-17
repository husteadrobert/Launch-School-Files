#Privacy 

class Machine

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  private

  attr_writer :switch
  
  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

#Fixed Array
class FixedArray
  attr_accessor :array, :size
  

  def []=(index, value)
    self.array[index] = value
  end

  def [](index)
    self.array.fetch(index)
  end


  def to_a
    self.array.to_a
  end

  def to_s
    self.array.to_s
  end

  #LS Solution
  # def to_a
  #   @array.clone
  # end
  # def to_s
  #   to_a.to_s
  # end

  def initialize(size)
    @array = Array.new(size) {|index| nil}
  end
end

#Students
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
    def initialize(name, year)
      super(name, year)
    end
end

# XXX


# Stack Machine Interpretation

class Minilang
  def initialize(string)
    @stack = []
    @register = 0
    @instructions = string
  end

  def eval
    list = @instructions.split
    list.each do |item|
      if item.to_i.to_s == item
        update_register(item.to_i)
      else
        case item
        when 'PRINT' then print
        when 'PUSH' then push
        when 'ADD' then add
        when 'SUB' then sub
        when 'MULT' then mult
        when 'DIV' then div
        when 'MOD' then mod
        when 'POP' then pop
        else
          puts "Invalid token: #{item}"
          break
        end
      end
    end
  end

  private

  def update_register(value)
    @register = value
  end

  def print
    puts "#{@register}"
  end

  def push
    @stack << @register
  end

  def add
    result = @stack.pop + @register
    @register = result
  end

  def sub
    result = @register - @stack.pop
    @register = result
  end

  def mult
    result = @stack.pop * @register
    @register = result
  end

  def div
    result = @register / @stack.pop
    @register = result
  end

  def mod
    result = @register % @stack.pop
    @register = result
  end

  def pop
    @register = @stack.pop
  end
end

# Number Guesser Part 1
class PingGame
  def play
    answer = (1..100).to_a.sample
    guesses = 7

    loop do
      puts "You have #{guesses} guesses remaining."
      puts "Enter a number between 1 and 100:"
      current_guess = gets.chomp.to_i
      if current_guess == answer
        puts "You win!"
        break
      elsif current_guess > answer
        puts "Your guess is too high"
      else
        puts "Your guess is too low"
      end
      puts ""
      guesses -= 1
      if guesses == 0
        puts "You are out of guesses. You lose."
        break
      end
    end
  end
end

#LS Solution
class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100
  RESULT_MESSAGE = {
    high: 'Your number is too high.',
    lose: 'You are out of guesses. You lose.',
    low:  'Your number is too low.',
    win:  'You win!'
  }.freeze

  def play
    reset
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_guess)
      puts RESULT_MESSAGE[result]
      return if result == :win
    end

    puts "\n", RESULT_MESSAGE[:lose]
  end

  private

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def check_guess guess_value
    return :win if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def obtain_guess
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)
      print "Invalid guess. "
    end
  end

  def reset
    @secret_number = rand(RANGE)
  end
end

# Number Guesser Part 2
class GuessingGame
  RESULT_MESSAGE = {
    high: 'Your number is too high.',
    lose: 'You are out of guesses. You lose.',
    low:  'Your number is too low.',
    win:  'You win!'
  }.freeze

  attr_reader :range, :max_guesses

  def initialize(range_start, range_finish)
    @range = range_start..range_finish
    @max_guesses = Math.log2(@range.size).to_i + 1
  end

  def play
    reset
    @max_guesses.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_guess)
      puts RESULT_MESSAGE[result]
      return if result == :win
    end

    puts "\n", RESULT_MESSAGE[:lose]
  end

  private

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def check_guess guess_value
    return :win if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def obtain_guess
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      guess = gets.chomp.to_i
      return guess if @range.cover?(guess)
      print "Invalid guess. "
    end
  end

  def reset
    @secret_number = rand(@range)
  end
end

game = GuessingGame.new(501, 1500)
game.play

# Highest and Lowest Ranking Cards
class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(@rank, @rank)
  end

  def <=>(other_object)
    value <=> other_object.value
  end
end

# Deck of Cards
class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @full_deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @full_deck << Card.new(rank, suit)
      end
    end
  end

  def draw
    if @full_deck.empty?
      reshuffle
    end
    drawn_card = @full_deck.sample
    remove_card(drawn_card)
    drawn_card
  end

  private

  def reshuffle
    initialize
  end

  def remove_card(drawn_card)
    @full_deck.delete_if {|card| card.rank == drawn_card.rank && card.suit == drawn_card.suit}
  end
end

#LS Solution

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

# Poker!

class PokerHand
  def initialize(deck)
    @hand = []
    5.times {@hand << deck.draw}
  end

  def print
    @hand.each do |card|
      puts "#{card}"
    end
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    return false unless flush?
    straight? && @hand.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    numbers = @hand.map{|card| card.value}
    unique_numbers = numbers.uniq
    unique_numbers.each do |num|
      return true if numbers.count(num) == 4
    end
    false
  end

  def full_house?
    numbers = @hand.map{|card| card.value}.uniq
    numbers.uniq.size == 2
  end

  def flush?
    suits = @hand.map {|card| card.suit}
    suits.uniq.count == 1
  end

  def straight?
    numbers = @hand.map {|card| card.value}.sort
    current_number = numbers[0]
    numbers[1..-1].each do |next_number|
      return false unless ((current_number + 1) == next_number)
      current_number = next_number
    end
    true
  end

  def three_of_a_kind?
    numbers = @hand.map{|card| card.value}
    unique_numbers = numbers.uniq
    unique_numbers.each do |num|
      return true if numbers.count(num) == 3
    end
    false
  end

  def two_pair?
    pairs = 0
    numbers = @hand.map{|card| card.value}
    unique_numbers = numbers.uniq
    unique_numbers.each do |num|
      if numbers.count(num) == 2
        pairs += 1
      end
    end
    pairs == 2
  end

  def pair?
    numbers = @hand.map{|card| card.value}
    unique_numbers = numbers.uniq
    unique_numbers.each do |num|
      return true if numbers.count(num) == 2
    end
    false
  end
end