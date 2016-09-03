#----Exercise 1
a = "Robert "
b = "Hustead"
puts "#{a+b}"

#----Exercise 2

num = 3463
#For thousands place
num / 1000
#For hundreds place
(num % 1000) / 100
#For tens place
(num % 100 )/ 10
#For ones place
num % 10

#----Exercise 3
movies = {movie1: 1991, movie2: 1992, movie3: 1993, movie4: 1994,
          movie5: 1995}
puts movies[:movie1]



#----Exercise 4
movie_dates = [1991, 1992, 1993, 1994, 1995]
puts movie_dates[0]
puts movie_dates[1]
puts movie_dates[2]
puts movie_dates[3]
puts movie_dates[4]


#----Exercise 5
puts factorial = 5*4*3*2
puts factorial = 6*factorial
puts factorial = 7*factorial
puts factorial = 8*factorial

#-----Exercise 6
puts 1.0 * 1.0
puts 2.5 * 2.5
puts 3.3 * 3.3

#-----Exercise 7
#This error message tell sme that a ) was used instead of a }.  This is a "syntax error"  
#I can also see the path to the irb (through usr/locla/rvm/rubies/ruby-2.0.../bin/irb)
