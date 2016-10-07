# Short Long Short

def short_long_short(message1, message2)
  new_message = ''
  message1.length > message2.length ? new_message << message2 << message1 << message2 : new_message << message1 << message2 << message1
  new_message
end

# What Century is That?
# LS Solution, I couldn't solve it.
def century(year)
  century = year / 100 + 1
  century -= 1 if year % 100 == 0
  century.to_s + century_suffix(century)
end

def century_suffix(century)
  return 'th' if [11, 12, 13].include? century % 100
  last_digit = century % 10

  case last_digit
  when 1 then 'st'
  when 2 then 'nd'
  when 3 then 'rd'
  else 'th'
  end
end

# Leap Years (Part 1)

def leap_year?(year)
  if year % 4 == 0 && year % 100 != 0
    true
  elsif year % 100 == 0 && year % 400 == 0
    true
  else
    false
  end
end

#Leap Years (Part 2)

def julian_leap_year?(year)
  year % 4 == 0
end

def leap_year?(year)
  return julian_leap_year?(year) if year < 1752
  if year % 4 == 0 && year % 100 != 0
    true
  elsif year % 100 == 0 && year % 400 == 0
    true
  else
    false
  end
end

# Multiples of 3 and 5

def multisum(num)
  sum = 0
  num.times do |iterator|
    if (iterator+1) % 3 == 0 || (iterator+1) % 5 == 0
      sum += (iterator+1)
    end
  end
  sum
end
#LS Solution
def multiple?(number, divisor)
  number % divisor == 0
end

def multisum(max_value)
  sum = 0
  1.upto(max_value) do |number|
    if multiple?(number, 3) || multiple?(number, 5)
      sum += number 
    end
  end
  sum
end

# Running Totals

def running_total(array)
  sum = 0
  array.map {|val| sum+=val}
end

# Convert a String to a Number!
#LS Solution, couldn't get it
DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

def string_to_integer(string)
  digits = string.chars.map { |char| DIGITS[char] }

  value = 0
  digits.each { |digit| value = 10 * value + digit }
  value
end

# Convert a String to a Signed Number!

def string_to_signed_integer(string)
  signature = nil
  string[0] == '-' ? signature = 'Negative' : signature = 'Positive'
  if string[0] == '-' || string[0] == '+' then string.delete!(string[0]) end
  if signature == 'Negative'
    string_to_integer(string) * -1
  else
    string_to_integer(string)
  end
end
#LS Solution
def string_to_signed_integer(string)
  case string[0]
  when '-' then -string_to_integer(string[1..-1])
  when '+' then string_to_integer(string[1..-1])
  else          string_to_integer(string)
  end
end

# Convert a Number to a String!
#LS Solution, couldn't figure this out
DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

def integer_to_string(number)
  result = ''
  loop do
    number, remainder = number.divmod(10)
    result.prepend(DIGITS[remainder])
    break if number == 0
  end
  result
end

# Convert a Signed Number to a String!

def signed_integer_to_string(number)
  if number > 0
    result = integer_to_string(number)
    result.prepend('+')
  elsif number < 0
    result = integer_to_string(number*-1)
    result.prepend('-')
  else
    result = '0'
  end
end
# LS Solution
def signed_integer_to_string(number)
  case number <=> 0
  when -1 then "-#{integer_to_string(-number)}"
  when +1 then "+#{integer_to_string(number)}"
  else         integer_to_string(number)
  end
end