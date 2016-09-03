first_array = [1,2,3,4,5]
second_array = first_array.map {|number| number+=2}

p first_array
p second_array

second_array = []

first_array.each do |number|
	second_array << number + 2
end

p first_array
p second_array