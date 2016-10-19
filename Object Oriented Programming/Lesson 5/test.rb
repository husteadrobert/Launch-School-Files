class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def winning_square(marker)
    square = nil
    WINNING_LINES.each do |line|
      square = find_risky_square(line, marker)
      break if square
    end
    square
  end

  def find_risky_square(line, marker)
    sqr = {}
    if @squares.values_at(*line).collect(&:marker).count(marker) == 2
      sqr = @squares.select do |k, v|
        line.include?(k) && v.marker == Square::INITIAL_MARKER
      end
    end
    sqr.keys.first
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " ".freeze

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :score, :marker

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class Human < Player
  attr_accessor :name

  def initialize(default_marker, default_name)
    super(default_marker)
    @name = default_name
  end

  def initialize_name_and_marker
    set_player_name
    set_player_marker
  end

  private

  def set_player_name
    player_name = nil
    loop do
      puts "What's your name?"
      player_name = gets.chomp
      break unless player_name.strip.empty?
      puts "Invalid Name, try again."
    end
    self.name = player_name.strip
  end

  def set_player_marker
    player_marker = nil
    loop do
      puts "What marker would you like to use? Please input a single character."
      player_marker = gets.chomp
      break unless player_marker.strip.empty? || player_marker.strip.size > 1
      puts "Invalid Character, try again."
    end
    self.marker = player_marker.strip
  end
end

module Displayable
  def display_scores
    puts "#{@human.name}'s Score: #{@human.score}"
    puts "Computer's Score: #{@computer.score}"
    puts ""
  end

  def display_winner
    if @human.score == TTTGame::MAX_SCORE
      puts "#{@human.name} wins!"
    else
      puts "The Computer wins!"
    end
    puts ""
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def joinor(arr, delimiter=', ', word='or')
    arr[-1] = "#{word} #{arr.last}" if arr.size > 1
    arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def clear
    system "clear"
  end
end

class TTTGame
  include Displayable
  HUMAN_MARKER = "X".freeze
  COMPUTER_MARKER = "O".freeze
  MAX_SCORE = 2

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER, "Player")
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = @human.marker
    @first_to_move = @human.marker
  end

  def play
    setup_game_environment
    loop do
      loop do
        display_board
        play_single_game
        enter_to_continue
        break if at_max_score?
        reset_board
      end
      display_winner
      break unless play_again?
      reset_game_environment
    end
    display_goodbye_message
  end

  private

  def reset_game_environment
    reset_board_and_scores
    display_play_again_message
  end

  def setup_game_environment
    clear
    display_welcome_message
    initialize_game_settings
  end

  def play_single_game
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end
    display_result
    update_scores
    display_scores
  end

  def initialize_game_settings
    answer = nil
    loop do
      puts "Play with (D)efaults or (P)ersonalize your game?"
      answer = gets.chomp
      break if answer.casecmp('d').zero? || answer.casecmp('p').zero?
      puts "Invalid Answer, try again."
    end
    return if answer.casecmp('d').zero?

    @human.initialize_name_and_marker
    if human.marker == 'O'
      @computer.marker = 'X'
    end

    select_first_mover
  end

  def select_first_mover
    answer = nil
    loop do
      puts "Who shall go first, (1)#{human.name} or (2) Computer?"
      puts "Please input 1 or 2:"
      answer = gets.chomp.to_i
      break if answer == 1 || answer == 2
      puts "Invalid Choice, try again."
    end
    if answer == 2
      @current_marker = computer.marker
      @first_to_move = computer.marker
    end
  end

  def enter_to_continue
    puts "(Press Enter to continue)"
    gets.chomp
  end

  def at_max_score?
    @human.score == MAX_SCORE || @computer.score == MAX_SCORE
  end

  def update_scores
    case board.winning_marker
    when human.marker then @human.score += 1
    when computer.marker then @computer.score += 1
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    square = if computer_can_win?
               board.winning_square(computer.marker)
             elsif human_will_win?
               board.winning_square(human.marker)
             elsif open_middle?
               5
             else
               board.unmarked_keys.sample
             end

    board[square] = computer.marker
  end

  def computer_can_win?
    !!board.winning_square(computer.marker)
  end

  def human_will_win?
    !!board.winning_square(human.marker)
  end

  def open_middle?
    board.unmarked_keys.include?(5)
  end

  def current_player_moves
    if @current_marker == HUMAN_MARKER
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset_board
    board.reset
    @current_marker = @first_to_move
    clear
  end

  def reset_board_and_scores
    @human.score = 0
    @computer.score = 0
    reset_board
  end
end

game = TTTGame.new
game.play
