module Hand
  def display_hand
    to_display = []
    @hand.each do |card|
      to_display << card.to_s
    end
    puts "#{self.class} has: #{joinor(to_display)}"
  end

  def <<(card)
    @hand << card
  end

  def hand_value
    value = 0
    @hand.each do |card|
      value += card.value
    end
    # Correct for Aces
    @hand.select { |card| card.face == "A" }.count.times do
      value -= 10 if value > 21
    end
    value
  end

  private

  def joinor(arr, delimiter=', ', word='and')
    arr[-1] = "#{word} #{arr.last}" if arr.size > 1
    arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
  end
end

module Displayable
  def display_welcome_message
    puts "Welcome to Twentyone.  First to 5 wins."
    puts ""
  end

  def display_goodbye_message
    puts "Gambling is an addiction.  Please do not bet real money on this game."
    puts ""
  end

  def clear_screen
    system "clear"
  end

  def show_initial_cards
    dealer.display_initial_hand
    puts ""
    player.display_hand
  end

  def display_result
    display_score
    display_winner
  end

  def display_score
    puts ""
    puts "Player Total: #{player.total}"
    puts "Dealer Total: #{dealer.total}"
    puts ""
  end

  def display_winner
    if find_winner == "Tie"
      puts "It's a push."
    else
      puts "#{find_winner} wins!"
    end
    puts ""
  end

  def display_scores
    puts "Player score: #{player.score}"
    puts "Dealer score: #{dealer.score}"
    puts ""
  end

  def display_overall_winner
    puts "***The #{find_winner} is the winner!***"
    puts ""
  end
end

class Player
  include Hand

  attr_accessor :hand, :score
  def initialize
    @hand = []
    @score = 0
  end

  def reset_hand
    @hand = []
  end

  def busted?
    hand_value > 21
  end

  def total
    hand_value
  end
end

class Dealer < Player
  def display_initial_hand
    puts "Dealer has a #{hand[0]} showing."
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    full_card_list = Card::SUITS.product(Card::FACES)
    deck = []
    full_card_list.each do |card|
      deck << Card.new(card[0], card[1])
    end
    deck.shuffle
  end

  def deal
    cards.pop
  end
end

class Card
  # rubocop:disable Metrics/LineLength
  SUITS = ['H', 'D', 'S', 'C'].freeze
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze
  # rubocop:enable Metrics/LineLength

  attr_reader :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "#{display_face} of #{display_suit}"
  end

  def value
    case @face
    when 'J', 'Q', 'K' then 10
    when 'A'           then 11
    else                    @face.to_i
    end
  end

  private

  def display_suit
    case @suit
    when 'H' then "Hearts"
    when 'D' then "Diamonds"
    when 'S' then "Spades"
    when 'C' then "Clubs"
    end
  end

  def display_face
    case @face
    when 'J' then "Jack"
    when 'Q' then "Queen"
    when 'K' then "King"
    when 'A' then "Ace"
    else          @face
    end
  end
end

class Game
  include Displayable
  DEALER_MAX = 17
  MAX_SCORE = 5
  attr_accessor :player, :dealer, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    clear_screen
    display_welcome_message
    loop do
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn
      display_result
      update_score
      display_scores
      break if at_max_score?
      setup_next_game
    end
    display_overall_winner
    display_goodbye_message
  end

  private

  def setup_next_game
    enter_to_continue
    reset_hands
    reset_deck
    clear_screen
  end

  def reset_deck
    @deck = Deck.new
  end

  def reset_hands
    player.reset_hand
    dealer.reset_hand
  end

  def at_max_score?
    player.score == MAX_SCORE || dealer.score == MAX_SCORE
  end

  def enter_to_continue
    puts "(Hit Enter to Continue)"
    gets.chomp
  end

  def deal_cards
    player.hand << deck.deal << deck.deal
    dealer.hand << deck.deal << deck.deal
  end

  def player_turn
    loop do
      answer = player_choice
      hit_player if answer == 'h'
      clear_and_show_dealer_hand
      puts ""
      player.display_hand
      break if answer == 's'
      if player.busted?
        puts "Player busts!"
        break
      end
    end
  end

  def clear_and_show_dealer_hand
    clear_screen
    dealer.display_initial_hand
  end

  def player_choice
    answer = nil
    loop do
      puts "Player Total: #{player.total}"
      puts "(H)it or (S)tand?"
      answer = gets.chomp.downcase
      break if answer.casecmp('h').zero? || answer.casecmp('s').zero?
      puts "Invalid, try again."
    end
    answer
  end

  def hit_player
    player.hand << deck.deal
  end

  def dealer_turn
    if player.busted?
      dealer.display_hand
      return
    end
    while dealer.total < DEALER_MAX
      dealer.hand << deck.deal
    end
    dealer.display_hand
    puts "Dealer busts!" if dealer.busted?
  end

  def find_winner
    if player.busted?
      return "Dealer"
    elsif dealer.busted?
      return "Player"
    else
      compare_hands
    end
  end

  def compare_hands
    if (21 - player.total) < (21 - dealer.total)
      "Player"
    elsif (21 - dealer.total) < (21 - player.total)
      "Dealer"
    else
      "Tie"
    end
  end

  def update_score
    player.score += 1 if find_winner == "Player"
    dealer.score += 1 if find_winner == "Dealer"
  end
end

Game.new.start
