def sum_square_difference(number)
  squared_sum = 1.upto(number).inject(:+)**2
  sum_squares = 0
  1.upto(number).each {|num| sum_squares += num**2}
  squared_sum - sum_squares
end









 puts   sum_square_difference(3) == 22
       # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
puts    sum_square_difference(10) == 2640
 puts   sum_square_difference(1) == 0
 puts   sum_square_difference(100) == 25164150