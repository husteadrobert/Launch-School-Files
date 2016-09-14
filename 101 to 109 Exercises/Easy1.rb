# Repeat Yourself
def repeat(message, num)
  num.times do
    puts "#{message}"
  end
end

# Odd
def is_odd?(num)
  (num % 2) == 1
end

# List of Digits
def digit_list(number)
  first = number.to_s.chars
  second = first.map do |num|
    num.to_i
  end
end

# How Many?
def count_occurrences(vehicles)
  result = {}
  vehicles.each do |name|
    if result.include?(name)
      result[name] += 1
    else
      result[name] = 1
    end
  end
  result.each do |key, value|
    puts "#{key} => #{value}"
  end
end
# LS Answer
def count_occurrences(array)
  occurrences = {}

  array.uniq.each do |element|
    occurrences[element] = array.count(element)
  end

  occurrences.each do |element, count|
    puts "#{element} => #{count}"
  end
end

# Reverse It (Part 1)
def reverse_sentence(message)
  message.split.reverse.join(' ')
end

# Reverse It (Part 2)
def reverse_words(message)
  array = message.split
  new_message = []
  array.each do |word|
    word.length >= 5 ? new_message << word.reverse : new_message << word
  end
  new_message.join(' ')
end
# alt solution
def reverse_words(message)
  array = message.split
  array.map do |word|
    word.reverse! if word.length >= 5
  end
  array.join(' ')
end
# LS solution
def reverse_words(message)
  array = message.split
  array.map do |word|
    word.reverse! if word.length >= 5
  end
  array.join(' ')
end

# Stringy Strings
def stringy(num)
  arr = []
  num.times do |iteration|
    iteration.odd? ? arr << '0' : arr << '1'
  end
  arr.join
end

# Array Average
def average(array)
  array.each.inject(:+) / array.length
end

# Sum of Digits
def sum (num)
  array = num.to_s.chars
  sum = 0
  array.each do |number|
    sum += number.to_i
  end
  sum
end
# LS solution
def sum(number)
  number.to_s.chars.map(&:to_i).reduce(:+)
end

# What's my Bonus?
def calculate_bonus(num, bool)
  bool ? num/2 : 0
end