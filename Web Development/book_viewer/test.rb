
result = []
11.times do |index|
text = File.read("data/chp#{index+1}.txt")
puts "#{index+1}"
result << "Yes@#{index+1}" if text.include?("truck")
end

puts result