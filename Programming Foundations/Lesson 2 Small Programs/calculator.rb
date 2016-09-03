require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yaml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def number?(input)
  integer?(input) || float?(input)
end

def operation_to_message(op)
  word =  case op
          when '1'
            'Adding'
          when '2'
            'Subtracting'
          when '3'
            'Multiplying'
          when '4'
            'Dividing'
          end
  word
end

first_digit = 0
second_digit = 0
prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt("Make sure you use a valid name.")
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  loop do
    prompt("Input first digit:")
    first_digit = gets().chomp().to_i

    if valid_number?(first_digit)
      break
    else
      prompt("Hmm...that doens't look like a valid number.")
    end
  end

  loop do
    prompt("Input second digit:")
    second_digit = gets().chomp().to_i

    if valid_number?(second_digit)
      break
    else
      prompt("Hmm...that doesn't look like a valid number.")
    end
  end
  
  operator_prompt = <<-MSG
    Desired Operation?
      1)add
      2)subtract
      3)multiply
      4)divide
  MSG
  prompt(operator_prompt)
  operation = 0
  loop do
    operation = gets().chomp()
    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt("Must choose 1, 2, 3, or 4")
    end
  end

  prompt("#{operation_to_message(operation)} the two numbers...")

  result =  case operation
            when '1'
              first_digit + second_digit
            when '2'
              first_digit - second_digit
            when '3'
              first_digit * second_digit
            when '4'
              first_digit.to_f / second_digit.to_f
            end
  prompt("The result is #{result}")

  prompt("Continue? Y/N")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
prompt("Thank you for using the calculator.")

# My first code for calculator, before refacturing.
=begin
if operation == "add" || operation == '1'
  prompt("Result: #{first_digit+second_digit}")
elsif operation == "subtract" || operation == '2'
  prompt("Result: #{first_digit-second_digit}")
elsif operation == "multiply" || operation == '3'
  prompt("Result: #{first_digit*second_digit}")
elsif operation == "divide" || operation == '4'
  if second_digit == 0
    prompt("Can't divide by 0")
  else
    prompt("Result: #{first_digit.to_f / second_digit.to_f}")
  end
else
  prompt("Unable to comply")
end
=end
