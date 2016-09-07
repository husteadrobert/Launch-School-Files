# Question 1
if false
  greeting = “hello world”
end

greeting
# I thought this would return an exception, but it returns nil

# Question 2
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

# Output: hi there
#         {a: 'hi'}

# Question 3
# A and B) one is one
# two is two
# three is three
# C) one is two
# two is three
# three is one

# Question 4

def generate_uuid
  uuid = ''

  characters = []
  (0..9).each { |number| characters << number}
  ('a'..'f').each { |letter| characters << letter}

  sections = [8,4,4,4,12]
  sections.each_with_index do |section, index|
    section.times {uuid += characters.sample }
    uuid += '-' unless index >= sections.index - 1
  end

  uuid
end

# Question 5
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  ip_status = false
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break if !is_a_number?(word)
  end
  ip_status = true
  return ip_status
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  ip_status = true
  if dot_seperated_words.size < 4
    return false
  end
  while dot_seperated words.size > 0 do
    word = dot_seperated_words.pop
    if !is_a_number?(word)
      ip_status = false
      break
    end
    ip_status
  end


