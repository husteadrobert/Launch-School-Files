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

class Player
  include Hand

  attr_accessor :hand
  def initialize
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
  SUITS = ['H', 'D', 'S', 'C'].freeze
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze

  attr_reader :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s # Change to two methods
    display_suit = case @suit
                   when 'H' then "Hearts"
                   when 'D' then "Diamonds"
                   when 'S' then "Spades"
                   when 'C' then "Clubs"
                   end
    display_face = case @face
                   when 'J' then "Jack"
                   when 'Q' then "Queen"
                   when 'K' then "King"
                   when 'A' then "Ace"
                   else          @face
                   end
    "#{display_face} of #{display_suit}"
  end

  def value
    case @face
    when 'J', 'Q', 'K' then 10
    when 'A'           then 11
    else                    @face.to_i
    end
  end
end

class Game
  DEALER_MAX = 17
  attr_accessor :player, :dealer, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end

  private

  def deal_cards
    player.hand << deck.deal << deck.deal
    dealer.hand << deck.deal << deck.deal
  end

  def show_initial_cards
    player.display_hand
    dealer.display_initial_hand
  end

  def player_turn # goto Player.hit_or_stand ?
    answer = nil
    loop do
      loop do
        puts "Player Total: #{player.total}"
        puts "(H)it or (S)tand?"
        answer = gets.chomp.downcase
        break if answer.casecmp('h').zero? || answer.casecmp('s').zero?
        puts "Invalid, try again."
      end
      player.hand << deck.deal if answer == 'h'
      player.display_hand
      break if answer == 's'
      break if player.busted?
    end
  end

  def dealer_turn
    while dealer.total < DEALER_MAX
      dealer.hand << deck.deal
    end
    dealer.display_hand
  end

  def show_result
    puts ""
    puts "Player Total: #{player.total}"
    puts "Dealer Total: #{dealer.total}"
    puts ""
  end
end

Game.new.start
