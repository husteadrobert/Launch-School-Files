
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
  new_deck = clubs + diamonds + hearts + spades
end

def deal_card!(deck)
  card = deck.sample
  deck.delete(card)
  card
end

def joinor(arr, punctuation = ', ', word = "and")
  if arr.length >= 3
    arr[-1] = "#{word} #{arr[-1]}"
    arr.join(punctuation)
  elsif arr.length == 2
    "#{arr[0]} #{word} #{arr[1]}"
  else
    "#{arr[0]}"
  end
end

def display_hand(hand)
  to_display = []
  hand.each do |card|
    to_display << card.last
  end
  joinor(to_display)
end

def hit!(hand, deck)
  hand << deal_card!(deck)
end

def calc_hand_value(hand)
  total = 0
  aces = 0
  hand.each do |card|
    if card.last == 'J'
      total += 10
    elsif card.last == 'Q'
      total += 10
    elsif card.last == 'K'
      total += 10
    elsif card.last == 'A'
      aces += 1
    else
      total += card.last.to_i
    end
  end
  aces.times do |card|
    if (total + 11) > 21
      total += 1
    else
      total += 11
    end
  end
  total
end

def is_bust?(hand)
  calc_hand_value(hand) > 21
end

def find_winner(player, dealer)
  player_score = calc_hand_value(player)
  dealer_score = calc_hand_value(dealer)
  if (player_score - 21).abs < (dealer_score-21).abs
    'Player'
  elsif (dealer_score - 21).abs < (player_score-21).abs
    'Dealer'
  else
    nil
  end
end


deck = initialize_deck
system('clear')


loop do # Overall Loop
  player_hand = []
  dealer_hand = []

  loop do # Single Game Loop
    player_hand << deal_card!(deck) << deal_card!(deck)
    dealer_hand << deal_card!(deck)
    dealer_status = "Dealers hand: #{display_hand(dealer_hand)} and Unknown Card"
    dealer_hand << deal_card!(deck)

    loop do # Player Turn
      system('clear')
      puts dealer_status
      puts "Players hand: #{display_hand(player_hand)}"
      puts "Players hand value: #{calc_hand_value(player_hand)}"
      break if is_bust?(player_hand)
      prompt "Hit (h) or Stand (s)?"
      action = gets.chomp

      if action.casecmp('h') == 0 #need more rigorous checking
        hit!(player_hand, deck)
      end
      break if action.casecmp('s') == 0
    end

    if is_bust?(player_hand)
      puts "You Busted!"
      break
    end

    system('clear')
    puts "Players hand: #{display_hand(player_hand)}"
    puts "Players hand value: #{calc_hand_value(player_hand)}"
    puts ""
    loop do # Dealer logic
      hit!(dealer_hand, deck) unless calc_hand_value(dealer_hand) >= 17
      break if calc_hand_value(dealer_hand) >= 17
    end
    puts "Dealers hand: #{display_hand(dealer_hand)}"
    puts "Dealer hand value: #{calc_hand_value(dealer_hand)}"
    puts "\n\n"
    
    # Determine if Bust or Winner
    if is_bust?(dealer_hand)
      puts "***Dealer busted, you win!***"
      break
    elsif find_winner(player_hand, dealer_hand) == 'Player'
      puts "***You win!***"
      break
    elsif find_winner(player_hand, dealer_hand) == 'Dealer'
      puts "---Dealer wins!---"
      break
    else
      puts "===It's a push.==="
      break
    end
  end

  puts "\n\n"
  prompt "Do you want to play again? Y/N"
  answer = gets.chomp
  break unless answer.casecmp('y') == 0
end

puts "I'm Batman"