puts "Please type your name:"
name = gets.chomp
puts "Nice to meet you, #{name}"
10.times do
  puts name
end

puts "What is your first name?"
first_name = gets.chomp
puts "What is your last name?"
last_name = gets.chomp
puts "Your full name is #{first_name + " " + last_name}"
