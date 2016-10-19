require 'pry'
module Hand

  def display_hand
    @hand.each do |card|
      puts "#{card}"
    end
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
    binding.pry
    value
  end

end


class Player
  include Hand
  attr_accessor :hand
  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
    @hand = []
  end

  def hit(deck)

  end

  def stay
  end

  def busted?
    hand_value > 21
  end

  def total #Don't need?
    hand_value
  end
end

class Dealer
  include Hand
  attr_accessor :hand
  def initialize
    # seems like very similar to Player... do we even need this?
    @hand = []
  end

  def display_initial_hand
    puts "#{hand[0]} and ??? (#{hand[1]})"
  end

  def deal
    # does the dealer or the deck deal?
  end

  def hit

  end

  def stay
  end

  def busted?
    hand_value > 21
  end

  def total
    hand_value
  end
end

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
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
  SUITS = ['H', 'D', 'S', 'C']
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  attr_reader :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "a #{@face} of #{suit}"
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
    #dealer_turn
    #show_result
  end

  private

  def deal_cards
    player.hand << Card.new('D', 'A') << Card.new('C', '10')
   # dealer.hand << deck.deal << deck.deal
  end

  def show_initial_cards
    player.display_hand
   # dealer.display_initial_hand
  end

  def player_turn #goto Player.hit_or_stand ?
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
      break if answer == 's'
      break if player.busted?
    end
    player.display_hand
  end

  def dealer_turn
    #unless player.bust?
    #hits till 17
  end

  def show_result
    #if dealer.bust?
    #player wins
    #else compare
    #display winner
  end

end

Game.new.start