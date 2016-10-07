# How old is Teddy?

puts "Teddy is #{rand(20..200)} years old!"

# How big is the room?

puts "Enter length in meters:"
length = gets.chomp.to_i
puts "Enter width in meters:"
width = gets.chomp.to_i
area_in_meters = (length * width).round(2)
area_in_feet = (area_in_meters * 10.7639).round(2)
puts "Area in square meters: #{area_in_meters} (#{area_in_feet} square feet)."

# Tip calculator

puts "What is the bill:"
bill = gets.chomp.to_f
puts "What is the tip percentage:"
percent = (gets.chomp.to_f) / 100

tip = (bill * percent).round(2)
bill += tip

bill = sprintf("%.2f", bill)
tip = sprintf("%.2f",tip)

puts "Tip: #{tip}"
puts "Total Bill: #{bill}"

# When will I Retire?

puts "How old are you?"
age = gets.chomp.to_i
puts "Age you will retire?"
retire_age = gets.chomp.to_i
years_left = retire_age - age
current_year = Time.now.year
retirement_year = current_year + (retire_age - age)
puts "It's #{current_year}. You will retire in #{retirement_year}."
puts "Only #{years_left} years left!"

# Greeting a user

puts "What is your name?"
name = gets.chomp
if name[name.length-1] == '!'
  puts "HELLO #{name.upcase.delete('!')}, WHY ARE WE YELLING?!"
else
  puts "Hello, #{name}!"
end
# or name.upcase.chop

# Odd Numbers

(1..99).each do |num|
  puts "#{num}\n" if num % 2 != 0
end

# Even Numbers

(0..99).each do |num|
  puts "#{num}\n" if num.even?
end

# Sum or Product of Consecutive Integers

puts "Enter a number greater than 0"
number = gets.chomp.to_i
puts "Do you want the (s)um or (p)roduct?"
choice = gets.chomp
total = 0
if choice == 's'
  total = (1..number).map.inject(:+)
  puts "The sum of the integers is #{total}"
elsif choice == 'p' 
  total = (2..number).map.inject(:*)
  puts "The product of the integers is #{total}"
end

