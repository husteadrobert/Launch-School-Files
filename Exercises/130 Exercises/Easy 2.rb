# From-To-Step Sequence Generator
def step(start, final, iterate_by)
  current_value = start
  while current_value < final
    yield(current_value)
    current_value += iterate_by
  end
  current_value
end

# Zipper
def zip(array1, array2)
  index = 0
  result_array = []
  while index < array1.size
    result_array << [array1[index], array2[index]]
    index += 1
  end
  result_array
end


# map
def map(array)
  result_array = []
  array.each do |value|
    result_array << yield(value)
  end
  result_array
end

# count
# LS Solution, no idea how to handle the arbitrary list of arguments
def count(*arguments)
  total = 0
  arguments.each { |item| total += 1 if yield(item) }
  total
end

# drop_while
def drop_while(array)
  result_array = []
  index = 0
  while index < array.length
    if !yield(array[index])
      result_array = array[index..array.length]
      break
    end
    index +=1
  end
  result_array
end
# LS Solution
def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end

  array[index..-1]
end

# each_with_index
def each_with_index(array)
  index = 0
  while index < array.length
    yield(array[index], index)
    index += 1
  end
  array
end
#LS Solution
def each_with_index(array)
  index = 0
  array.each do |item|
    yield(item, index)
    index += 1
  end
end

# each_with_object
def each_with_object(array, object)
  array.each do |value|
    yield(value, object)
  end
  object
end

# max_by
def max_by(array)
  return nil if array.empty?
  max = array.first
  array.each do |value|
    max = value if yield(value) > yield(max)
  end
  max
end
#LS Solution
def max_by(array)
  return nil if array.empty?

  max_element = array.first
  largest = yield(max_element)

  array[1..-1].each do |item|
    yielded_value = yield(item)
    if largest < yielded_value
      largest = yielded_value
      max_element = item
    end
  end

  max_element
end

# each_cons
def each_cons(array)
  0.upto(array.length-2) do |index|
    yield(array[index], array[index+1])
  end
  nil
end
#LS Solution
def each_cons(array)
  array.each_with_index do |item, index|
    break if index + 1 >= array.size
    yield(item, array[index + 1])
  end
end


#each_cons(2)
# LS Solution, couldn't solve
def each_cons(array, n)
  array.each_index do |index|
    break if index + n - 1 >= array.size
    yield(*array[index..(index + n - 1)])
  end
end