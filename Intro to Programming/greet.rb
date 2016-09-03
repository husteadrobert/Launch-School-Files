def greeting (name)
  "Hello, #{name}!"
end

puts "Whats your name?"
name = gets.chomp
puts greeting(name)

