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

