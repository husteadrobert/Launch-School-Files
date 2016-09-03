# For better looking messages
def prompt(message)
  puts "=> #{message}"
end

# Three validation methods to ensure proper input
def valid_loan_amount?(amount)
  amount > 0
end

def valid_apr?(num)
  num > 0.0
end

def valid_duration?(dur)
  dur > 0
end

# Initializing variables outside of their blocks for later use.
loan_amount = 0
apr = 0.0
duration = 0

prompt("Welcome to the Mortgage Calculator!")
prompt("-----------------------------------")

loop do # Main Loop
  # Getting loan amount and validating input
  prompt("Please input the loan amount in dollars:")
  loop do
    loan_amount = gets.chomp.to_i
    if valid_loan_amount?(loan_amount)
      break
    else
      prompt("Error: Please input a positive number greater than 0.")
      prompt("Please input the loan amount in dollars:")
    end
  end

  # Getting APR and validating input
  prompt("Please input the Annual Percentage Rate(APR)")
  prompt("Ex: 5.0% -> 5, 2.5% -> 2.5, 1.8% -> 1.8")
  loop do
    apr = gets.chomp.to_f
    if valid_apr?(apr)
      break
    else
      prompt("Error: Please input a positive number greater than 0.")
      prompt("Please input the Annual Percentage Rate(APR):")
      prompt("Ex: 5.0% -> 5, 2.5% -> 2.5, 1.8% -> 1.8")
    end
  end

  # Getting duration of loan and validating input
  prompt("Please input the loan duration in years:")
  loop do
    duration = gets.chomp.to_i
    if valid_duration?(duration)
      break
    else
      prompt("Error: Please input a positive number greater than 0.")
      prompt("Please input the loan duration in years:")
    end
  end

  # Calculating monthly payment
  monthly_rate = (apr / 100) / 12
  monthly_payment =
    loan_amount * (monthly_rate / (1 - (1 + monthly_rate)**-(duration * 12)))

  # Display monthly payment properly formatted
  prompt("-----------------------------------")
  prompt("Your monthly payment is: $#{format('%02.2f', monthly_payment)}")
  puts ""

  # Continue or Finish program
  prompt("Would you like to calculate a new monthly payment? Y/N")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

# Exiting Program / Saying Goodbye
prompt("I'm Batman")
