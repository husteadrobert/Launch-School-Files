# Combine Two Lists

def interleave(array1, array2)
  newarray = []
  array1.size.times do |index|
    newarray << array1[index] << array2[index]
  end
  newarray
end

# LS Solution
def interleave(array1, array2)
  result = []
  array1.each_with_index do |element, index|
    result << element << array2[index]
  end
  result
end

# Lettercase Counter

def letter_case_count(string)
  hash = { :lowercase => 0, :uppercase => 0, :neither => 0}
  string.chars.each do |element|
    if (element =~ /[a-z]/) == 0
      hash[:lowercase] += 1
    elsif (element =~ /[A-Z]/) == 0
      hash[:uppercase] += 1
    else
      hash[:neither] += 1
    end
  end
  hash
end

#LS Solution
def letter_case_count(string)
  counts = {}
  characters = string.chars
  counts[:lowercase] = characters.count { |char| char =~ /[a-z]/ }
  counts[:uppercase] = characters.count { |char| char =~ /[A-Z]/ }
  counts[:neither] = characters.count { |char| char =~ /[^A-Za-z]/ }
  counts
end

# Capitalize Words

def word_cap(string)
  array = string.split
  new_string = array.map do |element|
    word = element.chars
    if (word[0] =~ /[a-z]/) == 0
      word[0].upcase!      
    end
    word.join
  end
  new_string.join(' ')
end

#LS Solution
def word_cap(words)
  words.split.map(&:capitalize).join(' ')
end
#Regarding the concise solution, (&:method) is a shorthand for saying { |item| item.method } 

# Swap Case
# Needed help
def swapcase(string)
  characters = string.chars.map do |char|
    if char =~ /[a-z]/
      char.upcase
    elsif char =~ /[A-Z]/
      char.downcase
    else
      char
    end
  end
  characters.join('')
end


# Staggered Caps (Part 1)

def staggered_case(string)
  iterator = 0
  characters = string.chars.map do |char|
    iterator += 1
    if iterator.odd?
      char.upcase
    elsif iterator.even?
      char.downcase
    else
      char
    end
  end
  characters.join
end

#LS Solution
def staggered_case(string)
  result = ''
  need_upper = true
  string.chars.each do |char|
    if need_upper
      result += char.upcase
    else
      result += char.downcase
    end
    need_upper = !need_upper
  end
  result
end

# Staggered Caps (Part 2)
def staggered_case(string)
  iterator = 0
  characters = string.chars.map do |char|
    iterator += 1 if char =~ /[a-zA-Z]/
    #if char =~ /[a-z]/i <--LS
    if iterator.odd?
      char.upcase
    elsif iterator.even?
      char.downcase
    else
      char
    end
  end
  characters.join
end

# Multiplicative Average
def show_multiplicative_average(array)
  total = array.inject(:*).to_f
  total = total / array.length
  puts "The result is #{total.round(3)}"
  # puts format('%.3f', average)
end


# Multiply Lists
def multiply_list(arr1, arr2)
  new_arr = []
  arr1.each_with_index do |element, index|
    new_arr << element * arr2[index]
  end
  new_arr
end

# Multiply All Pairs
def multiply_all_pairs(arr1, arr2)
  new_array = []
  arr1.each do |arr1element|
    arr2.each do |arr2element|
      new_array << arr1element * arr2element
    end
  end
  new_array.sort
end

# The End is Near But Not Here

def penultimate(string)
  string.split[-2]
end