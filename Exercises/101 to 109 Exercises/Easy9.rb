# Welcome Stranger

def greetings (array, hash)
  name = array.map { |value| value}
  job = hash.map { |k, v| "#{v} " }
  "Hello, #{name.join(' ')}!  Nice to have a #{job.join}around."
end

# Double Doubles

def twice(number)
  characters = number.to_s.chars
  half_point, return_variable = characters.length.divmod(2)
  return number * 2 if return_variable > 1 || characters.length == 1
  return number * 2 if characters[0..half_point-1] != characters[half_point..-1]
  number
end

# Always Return Negative

def negative(number)
  number.abs * -1
end

# Counting Up

def sequence(number)
  array = []
  1.upto(number) {|index| array.push(index)}
  array
end

#LS Solution
def sequence(number)
  (1..number).to_a
end

# Uppercase Check

LOWERCASE = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

def uppercase?(string)
  string.chars.each do |character|
    if LOWERCASE.include?(character)
      return false
    end
  end
  true
end

#LS Solution
def uppercase?(string)
  string == string.upcase
end

#Another
def uppercase?(string)
  if string =~ /[a-z]/
   return false
  end
  true
end

# How long are you?

def word_lengths(string)
  string.split.map { |word| "#{word} #{word.length}"}
end

# Name Swapping

def swap_name(string)
  names = string.split
  "#{names[-1]}, #{names[0]}"
end

# LS Solution
def swap_name(name)
  name.split(' ').reverse.join(', ')
end

# Sequence Count

def sequence(times, rate)
  list = []
  1.upto(times) do |index|
    list.push(rate * index)
  end
  list
end

# LS Solution
def sequence(count, first)
  (1..count).map { |idx| idx * first }
end

# Grade book
def get_grade(num1,num2,num3)
  average = (num1 + num2 + num3) / 3.0
  grade = 'F'
  case 
  when average >= 90
    grade = 'A'
  when average >= 80
    grade = 'B'
  when average >= 70
    grade = 'C'
  when average >= 60
    grade = 'D'
  end
  grade
end

# LS Solution
def get_grade(s1, s2, s3)
  result = (s1 + s2 + s3)/3

  case result
  when 90..100 then 'A'
  when 80..89  then 'B'
  when 70..79  then 'C'
  when 60..69  then 'D'
  else              'F'
  end
end

# Grocery List
def buy_fruit(array)
  list = []
  array.each do |item|
    item.last.times {list.push(item.first)}
  end
  list
end

# LS Solution
def buy_fruit(list)
  list.map { |fruit, quantity| [fruit] * quantity }.flatten
end