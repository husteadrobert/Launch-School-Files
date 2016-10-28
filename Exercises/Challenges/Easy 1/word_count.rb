class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    clean_phrase = @phrase.gsub(/[^a-zA-Z0-9\']/, ' ').split
    word_hash = Hash.new(0)
    clean_phrase.each do |word|
      if word[0] == '\'' && word[-1] == '\''
        word = word[1..-2]
      end
      word_hash[word.downcase] += 1
    end
    word_hash
  end
end