# Sum of Sums

def sum_of_sums(array)
  total = 0
  until array.length == 0
    total += array.inject(:+)
    array.pop
    end
  total
end

# LS Solution
def sum_of_sums(numbers)
  sum_total = 0
  1.upto(numbers.size) do |count|
    sum_total += numbers.slice(0, count).reduce(:+)
  end
  sum_total
end
  
# Madlibs

puts "Enter a noun:"
noun = gets.chomp
puts "Enter a verb:"
verb = gets.chomp
puts "Enter an adjective:"
adj = gets.chomp
puts "Enter an adverb:"
adverb = gets.chomp

puts "Do you #{verb} your #{adj} #{noun} #{adverb}? That's hilarious!"


# Leading Substrings
def substrings_at_start(string)
  list = []
  1.upto(string.length) do |count|
    list << string[0..count-1]
  end
  list
end


# All Substrings
def substrings(string)
  list = []
  start_index = 0
  1.upto(string.length) do |count|
    #list << substrings_at_start(string[start_index..-1])
    list.concat(substrings_at_start(string[start_index..-1]))
    start_index += 1
  end
  list
end

# Palindromic Substrings

def palindromes(string)
  pal = []
  substring_list = substrings(string)
  substring_list.each do |word|
    if word == word.reverse && word.length != 1
      pal.push(word)
    end
  end
  pal
end

# fizzbuzz
def fizzbuzz(start, finish)
  result = []
  start.upto(finish) do |number|
    case 
    when number % 3 == 0 && number % 5 == 0
      result << "FizzBuzz"
    when number % 3 == 0
      result << "Fizz"
    when number % 5 == 0
      result << "Buzz"
    else
      result << "#{number}"
    end
  end
  result.join(', ')
end

# Double Char (Part 1)
def repeater(string)
  return_string = string.chars.map {|char| char*2}
  return_string.join
end

# LS Solution
def repeater(string)
  result = ''
  string.each_char do |char|
    result << char << char
  end
  result
end

# Double Char (Part 2)

def double_consonants(string)
  characters = string.chars
  return_string = characters.map do |char|
    if char =~ /[^aeiou]/ && char =~ /[A-Za-z]/
      repeater(char)
    else
      char
    end
  end
  return_string.join
end

# Convert number to reversed array of digits
def reversed_number(number)
  number.to_s.chars.reverse.join.to_i
end

# Get The Middle Character
