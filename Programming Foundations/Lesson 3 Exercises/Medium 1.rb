# Question 1

10.times {|number| puts (" " * number) + "The Flintstones Rock!" }

# Question 2

statement = "The Flintstones Rock"

statement_hash = {}
statement.chars do |letter|
  statement_hash[letter] = statement.count(letter)
end

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end

# Quesiton 3

puts "the value of 40 + 2 is " + (40 + 2)
# Error: Were trying to concat a str and int
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40+2}"

# Question 4

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# Output:
# 1
# 3

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# Output:
# 1
# 2

# Question 5
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end
# Bonus 1: It's to make sure the number divides evenly and is a factor.
# Bonus 2: It's returning the value, this is a method.

# Question 6

# The first implementation will MUTATE the buffer array argument, actually changing it.
# The second will return buffer, but not actually change the argument array.

# Question 7
# The def block does not have access to the local variable, 'limit'

# Question 8
# I had a huge def here, had to look at answer to get it.

input.split.map {|word|.capitalize}.join(' ')

# Question 9

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}


munsters.each do |name, value|
  case value["age"]
  when 0..17
    value["age_group"] = "kid"
  when 18..64
    value["age_group"] = "adult"
  else
    value["age_group"] = "adult"
  end
end