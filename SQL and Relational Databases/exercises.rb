require "sequel"

DB = Sequel.connect("postgres://localhost/billing2")

# DB[:customers].select(%i(customers__id name payment_token))
#               .join(:customers_services, customer_id: :customers__id)
#               .distinct
#               .each { |row| puts row[:row]}
# DB.disconnect


# DB[:customers].select(%i(customers__id name payment_token))
#               .left_join(:customers_services, customer_id: :customers__id)
#               .distinct
#               .where(service_id: nil)
#               .each { |row| puts row[:row] }

# DB.disconnect


# customer_info = DB[:customers].select do
#   [Sequel.as(split_part(name, ' ', 1), :first_name),
#    Sequel.as(split_part(name, ' ', 2), :last_name)]
#  end

# customer_info.left_join(:customers_services, customer_id: :customers__id)
#                       .left_join(:services, services__id: :service_id)
#                       .where { price >= 15.00 }.distinct
#                       .order(:last_name, :first_name)
#                       .limit(3).each {|row| puts row }



# DB.disconnect


# customer_info = DB[:customers].select do
#   [Sequel.as(split_part(name, ' ', 1), :first_name),
#    Sequel.as(split_part(name, ' ', 2), :last_name)]
# end

# customer_info.left_join(:customers_services, customer_id: :customers__id)
#              .left_join(:services, services__id: :service_id)
#              .where { price >= 15.00 }
#              .order(:last_name, :first_name)
#              .distinct
#              .limit(3)
#              .each { |row| puts "#{row[:last_name]}, #{row[:first_name]}" }
# DB.disconnect

# DB[:services].left_join(:customers_services, service_id: :services__id)
#              .left_join(:customers, customers__id: :customer_id)
#              .select { [description, count(name)]}
#              .group(:description)
#              .having { count(name) >= 3 }
#              .order(:description)
#              .each {|row| puts "#{row[:description]}, #{row[:count]}" }
# DB.disconnect


# DB[:customers_services].left_join(:services, services__id: :service_id)
#                        .select { [sum(price).cast(:money)] }
#                        .each { |row| puts row[:sum] }

# DB.disconnect

# customer_id = DB[:customers].insert(:name => "John Doe", :payment_token => "EYODHLCN")

# services = ['Unix Hosting', 'DNS', 'Whois Registration']
# service_ids = DB[:services].select(:id).where(description: services).map(:id)
# service_ids.each do |service_id|
#   DB[:customers_services].insert(customer_id: customer_id, service_id: service_id)
# end


# require 'sequel'

# DB = Sequel.connect "postgres://localhost/billing2"
# ds = DB[:customers]
#        .join(:customers_services, customer_id: :customers__id)
#        .join(:services, services__id: :service_id)
#        .order(:name)
#        .group(:name)
#        .select do
#          service_info = concat('  ', description, ' ', price.cast(:money))
#          service_list =
#            string_agg(service_info, "\n").order(lower(service_info))

#          [ name, service_list.as(:service_list) ]
#        end
# ds.each { |row| puts row[:name], row[:service_list] }

# DB.disconnect

puts "What database do you want to use?"
db_name = gets.chomp.strip
puts "What table do you want to use?"
table_name = gets.chomp.strip.to_sym

DB = Sequel.connect("postgres://localhost/#{db_name}")
table = DB[table_name]
table.columns.sort.each do |column_name|
  begin
  average = table.avg(column_name)
  puts "#{column_name}: #{format '%f', average}" if average
rescue Sequel::DatabaseError
end
end

DB.disconnect
