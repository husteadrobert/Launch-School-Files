def triangle(num)
  whitespace = num - 1
  stars = 1
  num.times do |iterator|
    puts "#{' ' * whitespace}#{'*' * stars}"
    stars += 1
    whitespace -=1
  end
end

triangle(20)