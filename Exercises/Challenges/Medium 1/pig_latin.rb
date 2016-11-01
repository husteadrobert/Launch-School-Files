class PigLatin
  SPECIAL_CASES = %w(xr yt)

  def self.translate(string)
    result = []
    string.split.each do |word|
      letters = word.chars
      if letters.first =~ /[aeiou]/ || SPECIAL_CASES.include?(letters[0..1].join)
        result << [word + 'ay']
      else
        vowel_index = letters.take_while{|letter| !(letter =~/[aeiou]/)}.length
        vowel_index += 1 if word.match(/qu/) && !(letters[letters.index('q')-1] =~ /[aeiou]/)
        consonants = word.slice!(0, vowel_index)
        result << [word + consonants + 'ay']
      end
    end
    result.join(' ')
  end
end
