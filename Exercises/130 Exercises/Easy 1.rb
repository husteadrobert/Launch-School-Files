# Enumerable Class Creation
class Tree
  include Enumerable

  def each
  end
end

# Optional Blocks
def compute
  if block_given?
    yield
  else
    'Does not compute.'
  end
end

# Find Missing Numbers
def missing(array)
  result_array = []
  index = 0
  while index < array.size - 1
    ((array[index] + 1)...array[index+1]).each {|num| result_array << num}
    index += 1
  end
  result_array
end
#LS Solution
def missing(array)
  result = []
  array.each_cons(2) do |first, second|
    result.concat(((first + 1)..(second - 1)).to_a)
  end
  result
end

# Divisors
def divisors(number)
  result_array = []
  (1..number).each do |divisor|
    result_array << divisor if number % divisor == 0
  end
  result_array
end
#LS Solution
def divisors(number)
  1.upto(number).select do |candidate|
    number % candidate == 0
  end
end

# Encrypted Pioneers
# Bad Solution
def cipher(letter)
  cipher_list = {'a' => 'n', 'b' => 'o', 'c' => 'p', 'd' => 'q',
                 'e' => 'r', 'f' => 's', 'g' => 't', 'h' => 'u',
                 'i' => 'v', 'j' => 'w', 'k' => 'x', 'l' => 'y',
                 'm' => 'z'}
  real_letter = ''
  if cipher_list.has_key?(letter.downcase)
    real_letter = cipher_list[letter.downcase]
  elsif cipher_list.has_value?(letter.downcase)
    real_letter = cipher_list.key(letter.downcase)
  else
    real_letter = letter
  end
  return real_letter
end

def rot13(string)
  letters = string.chars
  real_name = []
  letters.each do |letter|
      real_name << cipher(letter)
  end
  real_name.join()
end

puts rot13('Nqn Ybirynpr').capitalize
#LS Solution
def rot13(encrypted_text)
  encrypted_text.each_char.reduce('') do |result, encrypted_char|
    result + decipher_character(encrypted_char)
  end
end

def decipher_character(encrypted_char)
  case encrypted_char
  when 'a'..'m', 'A'..'M' then (encrypted_char.ord + 13).chr
  when 'n'..'z', 'N'..'Z' then (encrypted_char.ord - 13).chr
  else                         encrypted_char
  end
end

# Iterators: True for Any?
def any?(array)
  return false if array.empty?
  index = 0
  while index < array.size
    return true if yield(array[index])
    index += 1
  end
  false
end
#LS Solution
def any?(collection)
  collection.each { |item| return true if yield(item) }
  false
end

# Iterators: True for All?
def all?(array)
  return true if array.empty?
  array.each do |value|
    return false unless yield(value)
  end
  true
end
#LS Solution
def all?(collection)
  collection.each { |item| return false unless yield(item) }
  true
end

# Iterators: True for None?
def none?(array)
  return true if array.empty?
  array.each do |value|
    return false if yield(value)
  end
  true
end
# LS Solution
def none?(collection, &block)
  !any?(collection, &block)
end

# Iterators: True for One?
# Incorrect, goes through all
def one?(array)
  true_count = 0
  array.each do |value|
    true_count += 1 if yield(value)
    return false if true_count > 1
  end
  true_count == 1
end
#LS Solution
def one?(collection)
  seen_one = false
  collection.each do |element|
    next unless yield(element)
    return false if seen_one
    seen_one = true
  end
  seen_one
end

# Count Items
def count(array)
  result = 0
  array.each do |value|
    result += 1 if yield(value)
  end
  result
end