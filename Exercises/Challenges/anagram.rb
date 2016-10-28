class Anagram
  def initialize(word)
    @word = word
  end

  def match(word_array)
    base_hash = Hash.new(0)
    base_letters = @word.downcase.chars.sort
    base_letters.each {|letter| base_hash[letter] += 1}
    result = []
    word_array.each do |word|
      next if word.downcase == @word.downcase
      word_hash = Hash.new(0)
      word_letters = word.downcase.chars.sort
      word_letters.each {|letter| word_hash[letter] += 1}
      if word_hash == base_hash
        result << word
      end
    end
    result
  end
end 
# Don't need Hash, just sort == @sort
# Good LS Solution
# class Anagram
#   def initialize(word)
#     @word = word.downcase
#   end

#   def match(words)
#     words.select { |word| anagrams?(word) }
#   end

#   def anagrams?(word)
#     word.downcase != @word &&
#     word.downcase.chars.sort == @word.chars.sort
#   end
# end