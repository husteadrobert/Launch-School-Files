MAX_HAND = 21
DEALER_LIMIT = 17
GAME_LIMIT = 5

def prompt(message)
  puts "=> #{message}"
end

def initialize_deck
  clubs = [['C', 'A'], ['C', '2'], ['C', '3'], ['C', '4'], ['C', '5'],
           ['C', '6'], ['C', '7'], ['C', '8'], ['C', '9'], ['C', '10'],
           ['C', 'J'], ['C', 'Q'], ['C', 'K']]
  diamonds = [['D', 'A'], ['D', '2'], ['D', '3'], ['D', '4'], ['D', '5'],
              ['D', '6'], ['D', '7'], ['D', '8'], ['D', '9'], ['D', '10'],
              ['D', 'J'], ['D', 'Q'], ['D', 'K']]
  hearts = [['H', 'A'], ['H', '2'], ['H', '3'], ['H', '4'], ['H', '5'],
            ['H', '6'], ['H', '7'], ['H', '8'], ['H', '9'], ['H', '10'],
            ['H', 'J'], ['H', 'Q'], ['H', 'K']]
  spades = [['S', 'A'], ['S', '2'], ['S', '3'], ['S', '4'], ['S', '5'],
            ['S', '6'], ['S', '7'], ['S', '8'], ['S', '9'], ['S', '10'],
            ['S', 'J'], ['S', 'Q'], ['S', 'K']]
  clubs + diamonds + hearts + spades
end

def deal_card!(deck)
  card = deck.sample
  deck.delete(card)
  card
end

def joinor(arr, delimiter=', ', word='and')
  arr[-1] = "#{word} #{arr.last}" if arr.size > 1
  arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
end

def display_hand(hand)
  to_display = []
  hand.each do |card|
    #to_display << card.last
    case card.first
    when 'C'
      to_display << "#{card.last} of Clubs"
    when 'D'
      to_display << "#{card.last} of Diamonds"
    when 'H'
      to_display << "#{card.last} of Hearts"
    when 'S'
      to_display << "#{card.last} of Spades"
    end
  end
  joinor(to_display)
end

def hit!(hand, deck)
  hand << deal_card!(deck)
end

def add_aces(cards, current_total)
  cards.times do
    current_total += if (current_total + 11) > MAX_HAND
                       1
                     else
                       11
                     end
  end
  current_total
end

def calc_hand_value(hand)
  total = 0
  aces = 0
  hand.each do |card|
    if card.last == 'J' || card.last == 'Q' || card.last == 'K'
      total += 10
    elsif card.last == 'A'
      aces += 1
    else
      total += card.last.to_i
    end
  end
  total = add_aces(aces, total)
end

def bust?(hand)
  calc_hand_value(hand) > MAX_HAND
end

def find_winner(player, dealer)
  player_score = calc_hand_value(player)
  dealer_score = calc_hand_value(dealer)
  if (player_score - MAX_HAND).abs < (dealer_score - MAX_HAND).abs
    'Player'
  elsif (dealer_score - MAX_HAND).abs < (player_score - MAX_HAND).abs
    'Dealer'
  end
end

system('clear')

loop do # Overall Loop
  player_score = 0
  dealer_score = 0
  loop do
    player_hand = []
    dealer_hand = []
    continue = true

    loop do # Single Game Loop
      deck = initialize_deck
      player_hand << deal_card!(deck) << deal_card!(deck)
      dealer_hand << deal_card!(deck)
      dealer_status = "Dealers hand: #{display_hand(dealer_hand)}"
      dealer_status << " and an Unknown Card"
      dealer_hand << deal_card!(deck)

      loop do # Player Turn
        system('clear')
        puts dealer_status
        puts "Players hand: #{display_hand(player_hand)}"
        puts "Players hand value: #{calc_hand_value(player_hand)}"
        break if bust?(player_hand)
        prompt "Hit (h) or Stand (s)?"
        action = gets.chomp

        if action.casecmp('h').zero?
          hit!(player_hand, deck)
        end
        break if action.casecmp('s').zero?
      end

      if bust?(player_hand)
        puts "You Busted!"
        dealer_score += 1
        puts "\n"
        puts "Current Score: Player - #{player_score} Dealer - #{dealer_score}"
        puts "Hit Enter to Continue or (q) to Quit"
        answer = gets.chomp
        if answer.casecmp('q').zero? then continue = false end
        break
      end

      system('clear')
      puts "Players hand: #{display_hand(player_hand)}"
      puts "Players hand value: #{calc_hand_value(player_hand)}"
      puts ""
      loop do # Dealer logic
        hit!(dealer_hand, deck) if calc_hand_value(dealer_hand) < DEALER_LIMIT
        break if calc_hand_value(dealer_hand) >= DEALER_LIMIT
      end
      puts "Dealers hand: #{display_hand(dealer_hand)}"
      puts "Dealer hand value: #{calc_hand_value(dealer_hand)}"
      puts "\n\n"

      # Determine if Bust or Winner
      if bust?(dealer_hand)
        puts "***Dealer busted, you win!***"
        player_score += 1
      elsif find_winner(player_hand, dealer_hand) == 'Player'
        puts "***You win!***"
        player_score += 1
      elsif find_winner(player_hand, dealer_hand) == 'Dealer'
        puts "---Dealer wins!---"
        dealer_score += 1
      else
        puts "===It's a push.==="
      end
      puts "\n"
      puts "Current Score: Player - #{player_score} Dealer - #{dealer_score}"
      puts "Hit Enter to Continue or (q) to Quit"
      answer = gets.chomp
      if answer.casecmp('q').zero? then continue = false end
      break
    end
    break if !continue
    break if player_score == GAME_LIMIT || dealer_score == GAME_LIMIT
  end
  puts "\n\n"
  puts "The Player Wins!" if player_score == GAME_LIMIT
  puts "The Dealer Wins!" if dealer_score == GAME_LIMIT
  puts "\n\n"
  prompt "Do you want to play again? Y/N"
  answer = gets.chomp
  break unless answer.casecmp('y').zero?
end

puts "I'm Batman"
