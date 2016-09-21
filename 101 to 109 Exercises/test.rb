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






#B:O   X:K   D:Q   C:P   N:A
#G:T   R:E   F:S   J:W   H:U
#:I   L:Y   Z:M




 puts   block_word?('BATCH') == true
 puts   block_word?('BUTCH') == false
 puts   block_word?('jest') == true