# # good_dog_class.rb

# class Animal
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

#   def speak
#     "Hello!"
#   end
# end

# class GoodDog < Animal

#   def initialize(color)
#     super
#     @color = color
#   end

#   def speak
#     "#{self.name} says arf!"
#   end
# end

# class Cat < Animal
# end


# class BadDog < Animal
#   def initialize(age, name)
#     super(name)
#     @age = age
#   end
# end

# sparky = GoodDog.new("Brown")
# p sparky

# p BadDog.new(2, "bear")




# module Mammal
#   class Dog
#     def speak(sound)
#       p "#{sound}"
#     end
#   end

#   class Cat
#     def say_name(name)
#       p "#{name}"
#     end
#   end
# end

# buddy = Mammal::Dog.new
# kitty = Mammal::Dog.new

# buddy.speak('Arf!')
# kitty.say_name('kitty')











# class GoodDog
#   attr_accessor :name, :height, :weight

#   def initialize(n, h, w)
#     @name = n
#     @height = h
#     @weight = w
#   end

#   def speak
#     "#{name} says arf!"
#   end

#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end

#   # def info
#   #   "#{name} weighs #{weight} and is #{height} tall."
#   # end

#   def info
#   "#{self.name} weighs #{self.weight} and is #{self.height} tall."
#   end

#   def self.what_am_i
#     "I'm a GoodDog class!"
#   end


# end


# class GoodDog
#   DOG_YEARS = 7

#   attr_accessor :name, :age

#   @@number_of_dogs = 0

#   def initialize(n,a)
#     @@number_of_dogs += 1
#     self.name = n
#     self.age = a * DOG_YEARS
#   end

#   def to_s
#     "This dog's name is #{name} and it is #{age}"
#   end

#   def self.total_number_of_dogs
#     @@number_of_dogs
#   end
# end

# sparky = GoodDog.new("Sparky", 4)
# puts sparky
# puts "#{sparky}"




module SprayPaint
  def spray_paint(c)
    self.color = c
    puts "You're #{self.color} now."
  end
end

module LoadCargo
  def input_cargo(obj)
    self.storage = obj
    puts "You loaded #{obj} into the vehicle."
  end
end


class Vehicle
  include SprayPaint

  @@num_vehicles = 0

  attr_accessor :year, :color, :model, :speed


  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@num_vehicles += 1
  end

  def self.number_of_vehicles
    @@num_vehicles
  end


  def self.gas_mileage(gas, miles)
    mileage = miles / gas
    puts "Mileage: #{mileage}"
  end

  def speed_up
    self.speed += 1
    puts "Vehicle is traveling #{speed} mph"
  end

  def brake
    self.speed -= 1
    puts "Vehicle slowing down to #{speed} mph"
  end

  def shut_off
    self.speed = 0
    puts "Vehicle is off."
  end
  def current_speed
    puts "You are going #{speed} mph"
  end

  def declare_age
    "This vehicle is #{age} years old."
  end

  private

  def age
    Time.now.year - self.year
  end

end



class MyTruck < Vehicle
  DOORS = 2
  include LoadCargo

  #attr_accessor :color, :speed, :model, :year, :storage
  attr_accessor :storage

  def initialize(y,c,m)
    super
    @storage = nil
  end


  def to_s
    "This truck is a #{self.color}, #{self.year} #{self.model}"
  end
end


class MyCar < Vehicle
  DOORS = 4

  #attr_accessor :color, :speed, :model, :year
  
  #def initialize(y, c, m)
  #  super
  #end


  def to_s
    "This car is a #{self.color}, #{self.year} #{self.model}"
  end


end


sedan = MyCar.new(2000, "red", "Sedan")
trucker = MyTruck.new(1994, "blue", "Ford")

puts sedan
puts trucker

puts sedan.declare_age
puts trucker.declare_age
p Vehicle.number_of_vehicles
trucker.input_cargo("Sofa")
p MyCar.ancestors
p MyTruck.ancestors
p Vehicle.ancestors
trucker.speed_up