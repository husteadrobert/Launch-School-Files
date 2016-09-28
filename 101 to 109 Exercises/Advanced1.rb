# Madlibs Revisited
# Totally misunderstood the Question
text = File.read('madlibs')
words = text.split
hash = {}
word_list_by_type = []
word_type = ''
current_word = words.shift
loop do
  if current_word == "WordType"
    word_type = words.shift
    current_word = words.shift
  else
    until current_word == "WordType" || current_word == "END"
      word_list_by_type << current_word
      current_word = words.shift
    end
    hash[word_type] = word_list_by_type
    word_list_by_type = []
  end
  break if current_word == "END"
end

puts "The #{hash['Adjectives'].sample} #{hash['Subjects'].sample} #{hash['Adverbs'].sample}
#{hash['Verbs'].sample} the #{hash['Subjects'].sample}."

#LS Solution
ADJECTIVES = %w(quick lazy sleepy ugly).freeze
NOUNS      = %w(fox dog head leg cat tail).freeze
VERBS      = %w(spins bites licks hurdles).freeze
ADVERBS    = %w(easily lazily noisly excitedly).freeze

File.open('LSmadlibs') do |file|
  file.each do |line|
    puts format(line, noun:      NOUNS.sample,
                      verb:      VERBS.sample,
                      adjective: ADJECTIVES.sample,
                      adverb:    ADVERBS.sample)
  end
end

# Seeing Stars
# Ugly
def star(num)
  total_times = (num - 7) / 2
  times = total_times + 2
  buffer = 0
  until times < 0 do
    puts "#{' '*buffer}*#{' '*times}*#{' '*times}*"
    times -=1
    buffer +=1
  end
  puts "#{'*'*num}"
  times += 1
  buffer -=1
  until times > (total_times + 2)
    puts "#{' '*buffer}*#{' '*times}*#{' '*times}*"
    times +=1
    buffer -=1
  end
end
#LS Solution
def print_row(grid_size, distance_from_center)
  number_of_spaces = distance_from_center - 1
  spaces = ' ' * number_of_spaces
  output = Array.new(3, '*').join(spaces)
  puts output.center(grid_size)
end

def star(grid_size)
  max_distance = (grid_size - 1) / 2
  max_distance.downto(1) { |distance| print_row(grid_size, distance) }
  puts '*' * grid_size
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end

# Transpose 3x3
def transpose(matrix)
  new_matrix = []
  0.upto(2) do |number|
    new_matrix[number] = [matrix[0][number], matrix[1][number],matrix[2][number]]
  end
  new_matrix
end


# LS Solution
def transpose(matrix)
  result = []
  (0..2).each do |column_index|
    new_row = (0..2).map { |row_index| matrix[row_index][column_index] }
    result << new_row
  end
  result
end

# Transpose MxN
# Couldn't solve, LS Solution
def transpose(matrix)
  result = []
  number_of_rows = matrix.size
  number_of_columns = matrix.first.size
  (0...number_of_columns).each do |column_index|
    new_row = (0...number_of_rows).map { |row_index| matrix[row_index][column_index] }
    result << new_row
  end
  result
end

# Rotating Matrices

def rotate90(matrix)
  transpose(matrix.reverse)
end

# Permutations



# Fix the Bug
def my_method(array)
  if array.empty?
    []
  elsif array.size > 1
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end
# The elsif was evaluating to TRUE b/c the map is "true", but there is no block
# so it returns just nil.

# Merge Sorted Lists
def merge(array1, array2)
  if array1.empty? then return array2 end
  if array2.empty? then return array1 end
  array1_index = 0
  array2_index = 0
  merged_array = []
  final_size = array1.size + array2.size
  until merged_array.size == final_size do
    if array1[array1_index] <= array2[array2_index]
      merged_array << array1[array1_index]
      array1_index += 1
      if array1_index == array1.size
        merged_array <<  array2[array2_index..-1]
        return merged_array.flatten
      end
    else
      merged_array << array2[array2_index]
      array2_index +=1
      if array2_index == array2.size
        merged_array <<  array1[array1_index..-1]
        return merged_array.flatten
      end
    end
  end
end

# LS Solution
def merge(array1, array2)
  index2 = 0
  result = []

  array1.each do |value|
    while index2 < array2.size && array2[index2] <= value
      result << array2[index2]
      index2 += 1
    end
    result << value
  end

  result.concat(array2[index2..-1])
end

# Merge Sort
# Had to look online for recursion help
def merge_sort(array)
  return array if array.size <= 1
  cut = (array.size / 2) - 1
  array1, array2 = array[0..cut], array[cut+1..-1]
  merge(merge_sort(array1), merge_sort(array2))
end


