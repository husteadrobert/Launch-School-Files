# Question 1
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

flinstines = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Question 2

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flinstones << "Dino"
flinstones.push("Dino")

# Question 3

flinstones << "Dino" << "Hoppy"
flintstones.concat(["Dino","Hoppy"])
flintstones.concat(%w(Dino Hoppy))
flintstones.push("Dino").push("Hoppy")

# Question 4

advice = "Few things in life are as important as house training your pet dinosaur."

advice.slice!(advice.index("Few things in life are as important as "))
advice.slice!(0, advice.index('house'))

# Question 5

statement = "The Flintstones Rock!"

statement.count('t')
statement.scan('t').count

# Question 6

title = "Flintstone Family Members"

title.center(40)