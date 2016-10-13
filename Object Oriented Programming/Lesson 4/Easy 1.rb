# Question 1
# They are all objects.  You can find their class with
# name.class

# Question 2

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Vehicle
  include Speed
end

class Car < Vehicle
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck < Vehicle
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

c = Car.new
t = Truck.new
c.go_fast
t.go_fast

# Question 3
# Because small_car.class = Car

# Question 4
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

garfield = AngryCat.new

# Question 5
# The second one, b/c it has an '@' in front of the variable name.

# Question 6
class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end

# Question 7
# to_s will create a string version of the class and encoding.  It's
# part of the Object methods.

# Question 8
# Self refers to the caller of the instance method.(the calling object)

# Question 9
# self means this is a class method.  It means Cat.

# Question 10
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

paper_bag = Bag.new('brown', 'paper')