# require 'sequel'

# DB = Sequel.connect "postgres://localhost/billing2"
# DB[:customers].select(%i(customers__id name payment_token))
#              .distinct
#               .join(:customers_services, customer_id: :customers__id)
#               .each { |row| puts row[:row] }
# DB.disconnect


require 'sequel'

DB = Sequel.connect "postgres://localhost/billing2"

# customers = DB[:customers]
# puts "customers: #{customers.inspect}"

# columns = customers.select(%i(customers__id name payment_token))
# puts "columns: #{columns.inspect}"

# puts "-----"
# test = customers.select(:customers__id, :name, :payment_token)
# puts "test: #{test.inspect}"
# puts "-----"


# distinct_test = test.distinct

# join_test = distinct_test.join(:customers_services, customer_id: :customers__id)

# puts "join_test: #{join_test.inspect}"

# distinct = columns.distinct
# #puts "distinct: #{distinct.inspect}"

# joined = distinct.join(:customers_services, customer_id: :customers__id)
# puts "joined: #{joined.inspect}"

# puts
# joined.each { |row| puts row[:row] }

# puts
# join_test.each { |row| puts row.values }

# DB[:customers].select{ [customers__id, name, payment_token] }.each {|row| puts row }
# DB[:customers].select{ [:"customers__id", :"name", :"payment_token"]}.each {|row| puts row }
# DB[:customers].select{ [:customers__id, :name, :payment_token]}.each {|row| puts row }
# DB[:customers].select(:customers__id, :name, :payment_token).each {|row| puts row}



# dataset = DB[:customers].join(:customers_services, :customer_id => :id).select([:name, :customer_id])
                        
# dataset.each { |r| puts r }
# DB.disconnect


dataset = DB[:customers].select([:name, :customer_id]).join(:customers_services, :customer_id => :id).distinct(:customer_id)
dataset.each { |r| puts r }
dataset = DB[:customers].select(:name, :customer_id).join(:customers_services, :customer_id => :id).distinct(:customer_id)
dataset.each { |r| puts r }
DB[:customers].select(%i(customers__id name payment_token)).each {|row| puts row }
DB.disconnect
