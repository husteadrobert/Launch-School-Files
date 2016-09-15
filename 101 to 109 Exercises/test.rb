def swap(message)
  new_message = []
  message.split.map do |word|
    if word.length == 1
      new_message << word
      next
    end
    first_letter = word[0]
    last_letter = word[-1]
    new_word = last_letter << word[1..(word.length - 2)] << first_letter
    new_message << new_word
  end
  new_message.join(' ')
end





  puts  swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
puts    swap('Abcde') == 'ebcdA'
 puts   swap('a') == 'a'