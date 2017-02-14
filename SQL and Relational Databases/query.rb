require "sequel"

DB = Sequel.connect("postgres://localhost/sequel-single-table")

menu = DB[:menu_items]

def monetize(number)
  format("$%0.2f", number)
end

result = menu.select do
  labor_calc = prep_time / 60.0 * 12
  profit_calc = menu_price - ingredient_cost - labor_calc
  [item, menu_price, ingredient_cost, labor_calc.as(labor), profit_calc.as(profit)] #Need these .as(name) statements
end

result.each do |row|
  puts row[:item]
  puts "Price: #{monetize(row[:menu_price])}"
  puts "Ingredient cost: #{monetize(row[:ingredient_cost])}"
  puts "Labor: #{monetize(row[:labor])}"
  puts "Profit: #{monetize(row[:profit])}"
end


