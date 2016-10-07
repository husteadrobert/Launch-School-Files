# Longest Sentence

fileObj = File.new("/home/arstavial/Code/Launch\ School\ Files/101\ to\ 109\ Exercises/story", "r")
full_story = []
while (line = fileObj.gets)
  full_story.push(line)
end
fileObj.close

clean_story = full_story.join.gsub!("\n", ' ')

clean_story = clean_story.split(/[.!?]/)

longest = ""
clean_story.each do |sentence|
  sentence.length > longest.length ? longest = sentence : next
end

p longest.split.length
p longest

#LS Solution
text = File.read('sample_text.txt')
sentences = text.split(/\.|\?|!/)
largest_sentence = sentences.max_by { |sentence| sentence.split.size }
largest_sentence = largest_sentence.strip
number_of_words = largest_sentence.split.size

puts "#{largest_sentence}"
puts "Containing #{number_of_words} words"

# Now I Know my ABCs
def block_word?(string)
  hash = { 'B' => 'O', 'G' => 'T', 'V' => 'I', 
           'X' => 'K', 'R' => 'E', 'L' => 'Y',
           'D' => 'Q', 'F' => 'S', 'Z' => 'M',
           'C' => 'P', 'J' => 'W', 'N' => 'A', 'H' => 'U'}

  banned_letters = []
  bool = true
  letters = string.upcase.chars
  letters.each do |letter|
    if hash.has_key?(letter)
      banned_letters << hash[letter]
    elsif hash.has_value?(letter)
      banned_letters << hash.key(letter)
    end
  end
  banned_letters.each do |letter|
    if letters.include?(letter)
      bool = false
      break
    else
      next
    end
  end
  bool
end

#LS Solution
BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM).freeze

def block_word?(string)
  up_string = string.upcase
  BLOCKS.none? { |block| up_string.count(block) >= 2 }
end

# Lettercase Percentage Ratio

def letter_percentages(string)
  length = string.length
  hash = {lowercase:0, uppercase:0, neither:0}
  string.chars.each do |character|
    if character =~ /[A-Z]/
      hash[:uppercase] += 1
    elsif character =~ /[a-z]/
      hash[:lowercase] += 1
    else
      hash[:neither] += 1
    end
  end
  hash[:uppercase] = (hash[:uppercase] * 1.0) / length * 100
  hash[:lowercase] = (hash[:lowercase] * 1.0) / length * 100
  hash[:neither] = (hash[:neither] * 1.0) / length * 100
  hash
end

# LS Solution
def letter_percentages(string)
  counts = { lowercase: 0, uppercase: 0, neither: 0 }
  percentages = { lowercase: [], uppercase: [], neither: [] }
  characters = string.chars
  length = string.length

  counts[:uppercase] = characters.count { |char| char =~ /[A-Z]/ }
  counts[:lowercase] = characters.count { |char| char =~ /[a-z]/ }
  counts[:neither] = characters.count { |char| char =~ /[^A-Za-z]/ }

  calculate(percentages, counts, length)

  percentages
end

def calculate(percentages, counts, length)
  percentages[:uppercase] = (counts[:uppercase] / length.to_f) * 100
  percentages[:lowercase] = (counts[:lowercase] / length.to_f) * 100
  percentages[:neither] = (counts[:neither] / length.to_f) * 100
end

# Matching Parentheses?

def balanced?(string)
  characters = string.chars
  is_balanced = true
  left_paren = 0
  right_paren = 0
  characters.each do |char|
    left_paren += 1 if char == '('
    right_paren += 1 if char == ')' 
    if right_paren > left_paren
      is_balanced = false
      break
    end
  end
  left_paren == right_paren
end

# LS Solution
def balanced?(string)
  parens = 0
  string.each_char do |char|
    parens += 1 if char == '('
    parens -= 1 if char == ')'
    break if parens < 0
  end

  parens.zero?
end

# Triangle Sides

def triangle(side1, side2, side3)
  array = [side1, side2, side3].sort
  case
  when array.include?(0),(array[0] + array[1]) < array[2] then :invalid
  when array.count(side1) == 3 then :equilateral
  when array.uniq.length == 3 then :scalene
  else :isosceles
  end
end

#Tri-Angles
def triangle(num1, num2, num3)
  array = [num1, num2, num3].sort
  case 
  when array.reduce(:+) != 180, array.include?(0) then :invalid
  when array.include?(90) then :right
  when array.count {|num| num > 90} == 1 then :obtuse
  else :acute
  end
end

#Unlucky Days
def friday_13th?(year)
  num = 0
  12.times do |iterator|
    month = iterator + 1
    num += 1 if Time.new(year, month, 13).friday?
  end
  num
end

# LS Solution
require 'date'

def friday_13th?(year)
  unlucky_count = 0
  thirteenth = Date.new(year, 1, 13)
  11.times do
    unlucky_count += 1 if thirteenth.friday?
    thirteenth = thirteenth.next_month
  end
  unlucky_count
end

# Next Featured Number Higher than a Given Value

def featured(number)
  featured = 0
  loop do 
    number += 1
    if number % 7 == 0 &&
       number.odd? &&
       number.to_s.length == number.to_s.chars.uniq.length
        featured = number
        break
    end
    if number.to_s.length > 10
      puts "Invalid"
      featured = 0
      break
    end
  end
  featured
end

#LS Solutoin
def featured(number)
  number += 1
  number += 1 until number.odd? && number % 7 == 0

  loop do
    number_chars = number.to_s.split('')
    return number if number_chars.uniq == number_chars
    number += 14
    break if number >= 9_876_543_210
  end

  'There is no possible number that fulfills those requirements.'
end

# Bubble Sort

def bubble_sort!(array)
  final_index = array.length - 1
  while 0 <= final_index - 1 do
    (0..final_index - 1).each do |index|
      if array[index] > array[index+1]
        array[index], array[index+1] = array[index+1], array[index]
      end
    end
    final_index -= 1
  end
end

# LS Solution
def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      next if array[index - 1] <= array[index]
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end


# Sum Square - Square Sum

def sum_square_difference(number)
  squared_sum = 1.upto(number).inject(:+)**2
  sum_squares = 0
  1.upto(number).each {|num| sum_squares += num**2}
  squared_sum - sum_squares
end

