
def letter_percentages(string)
  length = string.length
  percentage = (length / 1.0)
  hash = {lowercase:0, uppercase:0, neither:0}
  string.chars.each do |character|
    if character =~ /[A-Z]/
      hash[:uppercase] += percentage
    elsif character =~ /[a-z]/
      hash[:lowercase] += percentage
    else
      hash[:neither] += percentage
    end
  end
  hash
end








 #puts   letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
 puts   letter_percentages('AbCd +Ef') #== { lowercase: 37.5, uppercase: 37.5, neither: 25 }
 puts   letter_percentages('123')# == { lowercase: 0, uppercase: 0, neither: 100 }