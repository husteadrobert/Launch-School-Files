


def fibonacci(number)
  total = 0
  now_sum = 1
  previous_sum = 1
  3.upto(number) do
    total = now_sum + previous_sum
    previous_sum = now_sum
    now_sum = total
  end
  total
end


def fibonacci_last(nth)
  answer = fibonacci(nth)
  answer.to_s.chars[-1]
end


#puts fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
#puts fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
#puts fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
#puts fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
#puts fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
#fibonacci_last(123456789) # -> 4

puts fibonacci_last(279)
puts fibonacci_last(3)
puts fibonacci_last(12)

puts fibonacci_last(837/100)