require 'pry'
INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
GAME_LIMIT = 5
START_PLAYER = 'Choose'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagnals

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}.  Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Chooes a square (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if empty_squares(brd).include?(5)
    square = 5
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def joinor(brd, punctuation = ',', word = "or")
  if brd.length >= 3
    brd[-1] = " #{word} #{brd[-1]}"
    brd.join(punctuation)
  elsif brd.length == 2
    "#{brd[0]} #{word} #{brd[1]}"
  else
    "#{brd[0]}"
  end
end

def place_piece!(brd, player)
  player == 'Player' ? player_places_piece!(brd) : computer_places_piece!(brd)
end

def alternate_player(current)
  if current == 'Player'
    'Computer'
  elsif current == 'Computer'
    'Player'
  end
end

loop do # Overall Loop
  human_score = 0
  computer_score = 0
  current_player = nil
  starting_player = nil
  system('clear')

  loop do
    prompt "Who goes first, Player (p) or Computer (c)?"
    answer = gets.chomp
    if answer == 'p'
      current_player = 'Player'
      starting_player = 'Player'
    elsif answer == 'c'
      current_player = 'Computer'
      starting_player = 'Computer'
    end
    break if !!current_player
    prompt "Please input p for Player or c for Computer"
  end

  loop do # GAME_LIMIT Loop
    board = initialize_board
    loop do # One Game
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end # One Game End

    display_board(board)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
      human_score += 1 if detect_winner(board) == 'Player'
      computer_score += 1 if detect_winner(board) == 'Computer'
    else
      prompt "It's a tie!"
    end
    prompt "Human Wins: #{human_score}  Computer Wins: #{computer_score}"
    break if human_score == GAME_LIMIT || computer_score == GAME_LIMIT
    current_player = starting_player
    prompt "Hit Enter to Continue or Q to Quit"
    continue = gets.chomp
    break if continue.casecmp('q') == 0
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end # End Overall Loop

prompt "I'm Batman"
