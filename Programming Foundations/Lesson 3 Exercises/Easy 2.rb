# Question 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.has_key?("Spot")
ages.member?("Spot")
ages.include?("Spot")

# Question 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

total_age = 0
ages.each do |name, age|
  total_age += age
end

ages.values.inject(:+)

# Question 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.keep_if?{|name, age| age < 100}

# Question 4
munsters_description = "The Munsters are creepy in a good way."

puts munsters_description.sub("Munsters", "munsters")
puts munsters_description.capitalize
puts munsters_description.swapcase
puts munsters_description.downcase
puts munsters_description.upcase

# Question 5
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages.merge!(additional_ages)

# Question 6
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.min

# Question 7
advice = "Few things in life are as important as house training your pet dinosaur."

advice.include?("Dino")
advice.match("Dino")

# Question 8
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.index { |name| name[0, 2] == "Be"}

# Question 9
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flinstones.map! do |name|
  name[0,3]
end

# Question 10
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flinstones.map! {|name| name.slice(0,3)}
