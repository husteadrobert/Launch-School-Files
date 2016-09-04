# CONSTANT Variable Declaration
VALID_CHOICES = %w(rock paper scissors lizard spock)

CHOICE_ABBR = {
  'r' => 'rock',
  'p' => 'paper',
  'sc' => 'scissors',
  'sp' => 'spock',
  'l' => 'lizard'
}

WINNING_COMBINATION = {
  'rock' => %w(scissors lizard),
  'paper' => %w(spock rock),
  'scissors' => %w(lizard paper),
  'spock' => %w(scissors rock),
  'lizard' => %w(spock paper)
}

GAME_LIMIT = 5

# For better looking output
def prompt(message)
  Kernel.puts("=> #{message}")
end

# I got the idea for this method by looking at other Code Reviews.
# It seemed a more elegant solution than a wall of if statements.
def win?(first, second)
  WINNING_COMBINATION[first].include?(second)
end

# Only Displays the results of the match
def display_results(result)
  case result
  when "Win"
    prompt("You win!")
  when "Lose"
    prompt("You lose!")
  when "Tie"
    prompt("It's a tie!")
  end
end

# Determines the result of a match.  If neither won, the only available
# result is a "Tie".
def determine_result(player, computer)
  if win?(player, computer)
    "Win"
  elsif win?(computer, player)
    "Lose"
  else
    "Tie"
  end
end

# Changes a single or double character input to the full VALID_CHOICE string
def validate(choice)
  CHOICE_ABBR[choice]
end

loop do # Overall Loop
  human_wins = 0
  computer_wins = 0

  prompt("Welcome to Rock, Paper, Scissors, Lizard, Spock!")

  loop do # Main Game Loop
    choice = ''

    # Get Input from the user and make sure it's valid.
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      menu = <<-MSG
      (r) for rock
         (p) for paper
         (sc) for scissors
         (l) for lizard
         (sp) for spock
      MSG
      prompt(menu)
      choice = Kernel.gets().chomp()
      if VALID_CHOICES.include?(choice)
        break
      elsif validate(choice)
        choice = validate(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    # Give the Computer a random choice, and display what each
    # player chose.
    computer_choice = VALID_CHOICES.sample
    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    # Determine the result of the match and adjust the score.
    result = determine_result(choice, computer_choice)
    if result == "Win"
      human_wins += 1
    elsif result == "Lose"
      computer_wins += 1
    end

    # Display to the player the result of the match and total overall score.
    display_results(result)
    prompt("Total Human Wins: #{human_wins}")
    prompt("Total Computer Wins: #{computer_wins}")

    # End the current game once the human or computer score reaches GAME_LIMIT
    break if human_wins == GAME_LIMIT || computer_wins == GAME_LIMIT
  end

  # Display the winner of the overall game.
  if human_wins == GAME_LIMIT
    prompt("The Human Player wins!")
  else
    prompt("The Computer wins!")
  end

  # Ask player if they would like to play again and verify input.
  prompt("Would you like to play again? (Yes) or (No)")
  answer = ''
  loop do
    answer = Kernel.gets().chomp()
    if answer.casecmp('yes').zero?
      break
    elsif answer.casecmp('no').zero?
      break
    else
      prompt("Please input (Yes) or (No)")
    end
  end
  break unless answer.downcase.start_with?('y')
end

# Thank the Player/Say Goodbye
prompt("I'm Batman.")
