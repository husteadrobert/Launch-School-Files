
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






puts    signed_integer_to_string(4321) == '+4321'
puts    signed_integer_to_string(-123) == '-123'
 puts   signed_integer_to_string(0) == '0'