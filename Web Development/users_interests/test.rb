require 'yaml'


file = Psych.load_file("data.yaml")


p file

# file.each_value do |value|
#   p value[:interests].count
  
# end
total = 0
file.each_value {|value| total += value[:interests].count}
p total