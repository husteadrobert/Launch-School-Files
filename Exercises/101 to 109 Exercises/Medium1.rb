# Rotation (Part 1)

def rotate_array(array)
  new_array = array.map {|value| value}
  first_element = new_array.first
  new_array.push(first_element)
  new_array.shift
  new_array
end

# LS Solution
def rotate_array(array)
  array[1..-1] + [array[0]]
end

# Rotation (Part 2)

def rotate_rightmost_digits(number, rotate)
  array = number.to_s.chars
  length = (array.length - rotate) - 1
  if length < 0
    return rotate_array(array).join.to_i
  end
  old_array = array.slice!(0..length)
  new_array = rotate_array(array)
  (old_array + new_array).join.to_i
end

# LS Solution
def rotate_rightmost_digits(number, n)
  all_digits = number.to_s.chars
  all_digits[-n..-1] = rotate_array(all_digits[-n..-1])
  all_digits.join.to_i
end

# Rotation (Part 3)
def max_rotation(number)
  length = number.to_s.length
  while length > 0
    number = rotate_rightmost_digits(number, length)
    length -= 1
  end
  number
end

# LS Solution
def max_rotation(number)
  number_digits = number.to_s.size
  number_digits.downto(2) do |n|
    number = rotate_rightmost_digits(number, n)
  end
  number
end

# 1000 Lights
def flip_switch(wall, index)
  wall[index-1] ? wall[index-1] = false : wall[index-1] = true
end

wall = (1..1000).to_a
wall.map! {|i| false}
overall_iterator = 1
until overall_iterator == 1000
  internal_iterator = overall_iterator
  loop do
    flip_switch(wall, internal_iterator)
    internal_iterator += overall_iterator
    break if internal_iterator >= 1000
  end
  overall_iterator += 1
end
arr = []
wall.each do |value, index|
  if value == true
    arr.push(index)
  end
end

# Diamonds!
def diamond(number)
  puts "\n"
  rows = number / 2
  open_space = number / 2
  stars = 1
  rows.times do
    puts "#{' ' * open_space}#{'*' * stars}"
    open_space -= 1
    stars += 2
  end
  puts "#{'*' * number}"
  rows.times do
    open_space += 1
    stars -= 2
    puts "#{' ' * open_space}#{'*' * stars}"
  end
end
# LS Solution
def print_row(grid_size, distance_from_center)
  number_of_stars = grid_size - 2 * distance_from_center
  stars = '*' * number_of_stars
  puts stars.center(grid_size)
end

def diamond(grid_size)
  max_distance = (grid_size - 1) / 2
  max_distance.downto(0) { |distance| print_row(grid_size, distance) }
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end

# Stack Machine Interpretation
def minilang(commands)
  stack = []
  register = 0
  commands.split.each do |command|
    if command =~ /\d/
      register = command.to_i
    else
      case command
      when 'PUSH'
        stack.push(register)
      when 'ADD'
        register += stack.pop
      when 'SUB'
        register -= stack.pop
      when 'MULT'
        register *= stack.pop
      when 'DIV'
        register /= stack.pop
      when 'MOD'
        register %= stack.pop
      when 'POP'
        register = stack.pop
      when 'PRINT'
        puts "#{register}"
      end
    end
  end
end

# Word to Digit
NUMBER = %w(zero one two three four five six seven eight nine)

def check_word(string)
  value = {}
  NUMBER.each_with_index do |val, index|
   value[val] = index
  end
  if NUMBER.include?(string)
    string = value[string].to_s
  else
    string
  end
end

def word_to_digit(string)
  value = {}
  NUMBER.each_with_index do |val, index|
    value[val] = index
  end
  words = string.split
  words.map! do |word|
    if word =~ /\W/
      check_word(word[0..-2]) + word[-1]
    else
      check_word(word)
    end
  end
  words.join(' ')
end

# LS Solution
DIGIT_HASH = {
  'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
  'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'
}.freeze

def word_to_digit(words)
  DIGIT_HASH.keys.each do |word|
    words.gsub!(/\b#{word}\b/, DIGIT_HASH[word])
  end
  words
end

# Fibonacci Numbers (Recursion)
def fibonacci(number)
 if number < 2
  number
 else
  fibonacci(number - 1) + fibonacci(number - 2)
  end
end

# Fibonacci Numbers (Procedural)
def fibonacci(number)
  total = 0
  now_sum = 1
  previous_sum = 1
  3.upto(number) do
    total = now_sum + previous_sum
    previous_sum = now_sum
    now_sum = total
  end
  total
end

# LS Solution
def fibonacci(nth)
  first, last = [1, 1]
  3.upto(nth) do
    first, last = [last, first + last]
  end

  last
end

# Fibonacci Numbers (Last Digit)
def fibonacci_last(nth)
  answer = fibonacci(nth)
  answer.to_s.chars[-1].to_i
end

# LS Solution for Larger Numbers, couldn't solve myself
def fibonacci_last(nth)
  last_2 = [1, 1]
  3.upto(nth) do
    last_2 = [last_2.last, (last_2.first + last_2.last) % 10]
  end

  last_2.last
end
