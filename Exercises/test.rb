require 'pry'


def each_cons(array, desired_elements)
  array.each_with_index do |item, index|
    break if index + desired_elements > array.size
    yield(item, array[index..(index + desired_elements-1)])
    #binding.pry
  end
end



# hash = {}
# each_cons([1, 3, 6, 10], 1) do |value|
#   hash[value] = true
# end
# puts hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
puts hash #== { 1 => 3, 3 => 6, 6 => 10 }

# hash = {}
# each_cons([1, 3, 6, 10], 3) do |value1, *values|
#   hash[value1] = values
# end
# puts hash == { 1 => [3, 6], 3 => [6, 10] }

# hash = {}
# each_cons([1, 3, 6, 10], 4) do |value1, *values|
#   hash[value1] = values
# end
# puts hash == { 1 => [3, 6, 10] }

# hash = {}
# each_cons([1, 3, 6, 10], 5) do |value1, *values|
#   hash[value1] = values
# end
# puts hash == {}