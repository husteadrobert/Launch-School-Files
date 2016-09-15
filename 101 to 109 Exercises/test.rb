def palindrome?(message)
  index = 0
  reverse_index = -1
  (message.length / 2).times do
    return false if message[index] != message[reverse_index]
    index += 1
    reverse_index -= 1
  end
  true
end

def real_palindrome?(message)
  palindrome?(message.downcase.gsub(/\W/, ''))
end

def palindromic_number?(nums)
  nums.to_s.chars == nums.to_s.chars.reverse
end




puts palindromic_number?(34543) == true
puts palindromic_number?(123210) == false
puts palindromic_number?(22) == true
puts palindromic_number?(5) == true