# input = ""

# while input != "STOP" do
#  puts "Input String:"
#  input = gets.chomp
#  puts "You typed: #{input}"
# end


test_array = [10,20,30,40,50]

test_array.each_with_index do |value, index|
  puts "#{index+1} - #{value}"
end

def countdown(start)
  if start <= 0
    return start
  else
    puts start
    start-=1
    countdown(start)
  end
end
