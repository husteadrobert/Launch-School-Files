test_array = [1,2,3,4,5,6,7,8,9,10]

=begin Exercise 1
test_array.each { |number| puts number }
=end

=begin Exercise 2
test_array.each do |number|
  if number > 5
    puts number
  end
end
=end

=begin Exercise 3
new_array = test_array.select {|number| number.odd?}
puts new_array

new_array = test_array.select {|number| number % 2 >= 1 }
puts new_array
=end

#Exercise 4
test_array.push(11)
test_array.unshift(0)


#Exercise 5
test_array.pop
test_array.push(3)

#Exercise 6
test_array.uniq!

#Exercise 8
new_hash_format = {name: "Bob", height: 185, weight: 80}
old_hash_format = {:name => "Bob", :height => 185, :weight => 80}

#Exercise 9
h = {a:1, b:2, c:3, d:4}
h[:b]
h[:e] = 5
h.delete_if{|key, value| value < 3.5}

#Exercise 10
hash_array = [{name: "Bob"}, {name: "Jack"}]
array_hash = {names: ["Bob","Jack"]}

#Exercise 12
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts["Joe Smith"][:email] = contact_data[0][0]
contacts["Joe Smith"][:address] = contact_data[0][1]
contacts["Joe Smith"][:phone] = contact_data[0][2]
contacts["Sally Johnson"][:email] = contact_data[1][0]
contacts["Sally Johnson"][:address] = contact_data[1][1]
contacts["Sally Johnson"][:phone] = contact_data[1][2]

#Exercise 13
p contacts["Joe Smith"][:email]
p contacts["Sally Johnson"][:phone]
#Cleaner from answers
puts "Joe's email is: #{contacts["Joe Smith"][:email]}"
puts "Sally's phone number is: #{contacts["Sally Johnson"][:phone]}"

#Exercise 14 ---Needed help from Solution
contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}

fields = [:email, :address, :phone]

contacts.each do |name, hash|
  fields.each do |field|
    hash[field] = contact_data.shift
  end
end

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}
fields = [:email, :address, :phone]

contacts.each_with_index do |(name, hash), index|
  fields.each do |field|
    hash[field] = contact_data[index].shift
  end
end

#Exercise 15
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if{|word| word.start_with?('s')}
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if{|word| word.start_with?('s', 'w')}

#Exercise 16
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

a.map! do |i|
  i.split(' ')
end
a.flatten!

#Exercise 17---Same
hash1 = {shoes: "nike", "hat" => "adidas", :hoodie => true}
hash2 = {"hat" => "adidas", :shoes => "nike", hoodie: true}

if hash1 == hash2
  puts "These hashes are the same!"
else
  puts "These hashes are not the same!"
end

