# Find the Class
puts 'Hello'.class
puts 5.class
puts [1, 2, 3].class

#Create the Class
class Cat
end

#Creat the Object

kitty = Cat.new

#What Are You?
class Cat
  def initialize
    puts "I'm a cat!"
  end

end

#Hello, Sophie! (Part 1)
class Cat
  def initialize(n)
    @name = n
    puts "Hello! My name is #{@name}!"
  end
end

#Hello, Sophie! (Part 2)

class Cat
  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello, my name is #{@name}!"
  end
end

#Reader
class Cat
  attr_reader :name
  def initialize(n)
    @name = n
  end
  def greet
    puts "Hello, my name is #{name}!"
  end
end

#Writer
class Cat
  attr_accessor :name
  def initialize(n)
    @name = n
  end
  def greet
    puts "Hello, my name is #{name}!"
  end
end

kitty = Cat.new("Sophie")
kitty.greet
kitty.name = "Luna"
kitty.greet

#Walk the Cat
module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

