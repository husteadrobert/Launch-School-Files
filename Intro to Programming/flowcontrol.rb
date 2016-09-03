puts "Please input a String"
input_string = gets.chomp

def to_upper (input_string)
  if input_string.length > 10
    return input_string.upcase
  else
    return input_string
  end
end

puts to_upper(input_string)


def to_upper2(input_string)
  return input_string.upcase if input_string.length > 10
  input_string
end

puts to_upper2(input_string)

def to_upper3(input_string)
  input_string.length > 10 ? input_string.upcase : input_string
end

puts to_upper3(input_string)

#----------


puts "Please input a number 0 - 100"
number = gets.chomp.to_i
reply = case 
  when number >= 0 && number <= 50
    "Number is between 0 and 50"
  when number > 50 && number <= 100
    "Number is between 51 and 100"
  else
    if num < 0
      "You can't enter a negative number!"
    else
      "Number is over 100"
    end
  end
puts reply

