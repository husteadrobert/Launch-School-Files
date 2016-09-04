# Question 1
# Expected Output:
# 1
# 2
# 2
# 3

# Question 2
# The basic difference between ! and ? is that ! will usually MUTATE the caller of the method,
# while ? will return a TRUE or FALSE value.
# 1. != means NOT EQUAL, and is usually used in conditional statements.
# 2. !user_name would be NOT user_name.  Anything that is not FALSE or NIL will resolve to TRUE, so
# !user_name will most likely resolve to FALSE.
# 3. The ! at the end of a method name indicates the method most likely will MUTATE the caller, so in this
# example words.uniq!, words will become an array that only contains unique(non repeated) information in each
# cell.
# 4. Just putting ? in front of a variable will result in an error, but the ? is also the ternary operator 
# for if...else.
# 5. The ? at the end of a method call usually indicates that the method will return a TRUE or FALSE.
# For example, array.include?("Hi!") will return true if the array includes the value "Hi!", and false if it
# does not.
# 6. !! will return the boolean value of a variable.

# Question 3
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!("important", "urgent")

# Question 4
numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1) #This deletes the number at index 1, or the number 2 in this array.
numbers.delete(1) #This deletes the all instances of the number 1 from the array.

# Question 5
(10..100).cover?(42)

# Question 6
famous_words = "seven years ago..."

famous_words.insert(0, "Four score and ")
famous_words.prepent("Four score and ")

# Question 7
# eval(how_deep) Would equal 42

# Question 8
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flintstones.flatten!

# Question 9
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

flintstones.assoc("Barney")

# Question 10
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = {}
flintstones.each_with_index do |value, index|
  flintstones_hash[value] = index
end
