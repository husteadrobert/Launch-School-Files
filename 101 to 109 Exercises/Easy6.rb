# Cute angles

DEGREE = "\xC2\xB0"

MINUTES_IN_DEGREE = 60
SECONDS_IN_MINUTE = 60
SECONDS_PER_DEGREE = MINUTES_IN_DEGREE * SECONDS_IN_MINUTE

def dms(degrees)
  total_seconds = (SECONDS_PER_DEGREE * degrees).round
  degrees, remaining_seconds = total_seconds.divmod(SECONDS_PER_DEGREE)
  minutes, seconds = remaining_seconds.divmod(SECONDS_IN_MINUTE)
  format(%(#{degrees}#{DEGREE}%02d'%02d"), minutes, seconds)
end

# Delete vowels
#Failed
VOWELS = %w(a e i o u)

def remove_vowels(array)
  new_arr = []
  array.each do |word|
    new_word = []
    new_word = word.chars.map do |letter|
      if VOWELS.include?(letter.downcase)
        next
      else
        letter
      end
    end
    new_arr << new_word.join('')
  end
  new_arr.join(' ')
end
#LS Solution
def remove_vowels(strings)
  strings.map { |string| string.delete('aeiouAEIOU') }
end

# Fibonacci Number Location By Length
# My maybe ok Solution
def fibonacci(number)
  if number < 2
    number
  else
    fibonacci(number - 1) + fibonacci(number - 2)
  end
end

def find_fibonacci_index_by_length(length)
  number = 1
  until fibonacci(number).to_s.size >= length
    number += 1
  end
  number
end
#LS Solution
def find_fibonacci_index_by_length(number_digits)
  first = 1
  second = 1
  index = 2

  loop do
    index += 1
    fibonacci = first + second
    break if fibonacci.to_s.size >= number_digits

    first = second
    second = fibonacci
  end

  index
end

# Reversed Arrays (Part 1)
# Needed help
def reverse!(array)
  left_index = 0
  right_index = -1

  while left_index < (array.size / 2)
    array[left_index], array[right_index] = array[right_index], array[left_index]
    left_index += 1
    right_index -= 1
  end

  array
end

# Reversed Arrays (Part 2)
def reverse(array)
  left_index = 0
  right_index = -1
  copy_array = array
  while left_index < (array.size / 2)
    copy_array[left_index], copy_array[right_index] = copy_array[right_index], copy_array[left_index]
    left_index += 1
    right_index -= 1
  end
  copy_array
end

#LS Solution
def reverse(array)
  result_array = []
  array.reverse_each { |element| result_array << element }
  result_array
end

#Combining Arrays

def merge (arr1, arr2)
  arr1.concat(arr2).uniq
end

def merge(array_1, array_2)
  array_1 | array_2
end

# Halvsies

def halvsies(array)
  new_array=[]
  if array.length.odd?
    first_size = (array.length / 2) + 1
  else
    first_size = array.length / 2
  end
  new_array << array.slice(0..(first_size-1))
  new_array << array.slice(first_size..-1)
end

#LS Solution
def halvsies(array)
  first_half = array.slice(0, (array.size / 2.0).ceil)
  second_half = array.slice(first_half.size, array.size - first_half.size)
  [first_half, second_half]
end


# Find the Duplicate

def find_dup(array)
  hash_table = Hash.new(0)
  array.each do |number|
    hash_table[number] += 1
  end
  key = hash_table.select{|k,v| v > 1}.keys
  key[0]
end

def find_dup(array)
  array.find { |element| array.count(element) == 2 }
end