# Question 1
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

total_age = 0
munsters.each do |name, info|
  total_age += info["age"] if info["gender"] == "male"
end

# Question 2
munsters.each do |name, info|
  puts "#{name} is a #{info["age"]} year old #{info["gender"]}"
end

# Question 3
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
# I'd make both statements in the def either << or +=, not one and the other.

# Question 4
sentence = "Humpty Dumpty sat on a wall."
sentence.split(/\W/).reverse.join(' ') + '.'

# Question 5
answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
# Output = 42 - 8 = 34

# Question 6
# Honestly, this one still confuses me.  I'll need to research argument passing
# some more.  

# Question 7

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")
# Output: Paper

# Question 8
bar(foo)
#Output: No