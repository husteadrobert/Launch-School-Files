# Searching 101

numbers = []
5.times do
  puts "Input a number:"
  num = gets.chomp.to_i
  numbers << num
end

puts "Enter last number:"
num = gets.chomp.to_i

if numbers.include?(num)
  puts "#{num} is in #{numbers}"
else
  puts "#{num} isn't in #{numbers}"
end

# Arithmetic Integer

puts "Input a number:"
num1 = gets.chomp.to_i
puts "Another:"
num2 = gets.chomp.to_i

puts "#{num1} + #{num2} = #{num1 + num2}"
puts "#{num1} - #{num2} = #{num1 - num2}"
puts "#{num1} * #{num2} = #{num1 * num2}"
puts "#{num1} / #{num2} = #{num1 / num2}"
puts "#{num1} % #{num2} = #{num1 % num2}"
puts "#{num1} ** #{num2} = #{num1 ** num2}"

# Counting the Number of Characters

puts "Input string: "
message = gets.chomp
length = 0
arr = message.split
arr.each do |word|
  length += word.length
end

puts "#{length} characters."
#LS Solution
print 'Please write word or multiple words: '
input = gets.chomp
number_of_characters = input.delete(' ').size
puts "There are #{number_of_characters} characters in \"#{input}\"."

# Multiplying Two Numbers

def multiply(num1, num2)
  num1 * num2
end

# Squaring an Argument

def square(n)
  multiply(n, n)
end

# Exclusive Or

def xor?(arg1, arg2)
  return true if (arg1 && !arg2) || (!arg1 && arg2)
  false
end

# Odd Lists

def oddities(array)
  new_array = []
  count = 1
  array.each do |element|
    new_array << element if count.odd?
    count += 1
  end
  new_array
end

# Palindromic Strings (Part 1)

def palindrome?(message)
  index = 0
  reverse_index = -1
  (message.length / 2).times do
    return false if message[index] != message[reverse_index]
    index += 1
    reverse_index -= 1
  end
  true
end
#LS Solution
def palindrome?(string)
  string == string.reverse
end

# Palindromic Strings (Part 2)
def real_palindrome?(message)
  palindrome?(message.downcase.gsub(/\W/, ''))
end

# Palindromic Numbers

def palindromic_number?(nums)
  nums.to_s.chars == nums.to_s.chars.reverse
end
