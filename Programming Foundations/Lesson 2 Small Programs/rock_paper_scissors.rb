VALID_CHOICES = %w(rock paper scissors spock lizard)

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

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  WINNING_COMBINATION[first].include?(second)
end

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

def determine_result(player, computer)
  if win?(player, computer)
    "Win"
  elsif win?(computer, player)
    "Lose"
  else
    "Tie"
  end
end

def validate(choice)
  CHOICE_ABBR[choice]
end

loop do # Overall Loop
  human_wins = 0
  computer_wins = 0
  prompt("Welcome to Rock, Paper, Scissors, Lizard, Spock!")
  loop do # Main Game Loop
    choice = ''

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

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    result = determine_result(choice, computer_choice)
    if result == "Win"
      human_wins += 1
    elsif result == "Lose"
      computer_wins += 1
    end

    display_results(result)
    prompt("Total Human Wins: #{human_wins}")
    prompt("Total Computer Wins: #{computer_wins}")

    break if human_wins == GAME_LIMIT || computer_wins == GAME_LIMIT
  end

  if human_wins == GAME_LIMIT
    prompt("The Human Player wins!")
  else
    prompt("The Computer wins!")
  end
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

prompt("I'm Batman.")
