#Generic Greeting (Part 1)

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

#Hello, Chloe!

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(name)
    self.name = name
  end

end

#Identify Yourself (Part 1)
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  def identify
    self
  end

end

#Generic Greeting (Part 2)
class Cat
  attr_reader :name
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end


  def initialize(name)
    @name = name
  end

  def personal_greeting
    puts "Hello! My name is #{name}!"
  end

end

#Counting Cats
class Cat
  @@number_of_cats = 0

  def initialize
    @@number_of_cats += 1
  end

  def self.total
    @@number_of_cats
  end
end

#Colorful Cat
class Cat
  COLOR = 'purple'
  attr_reader :name, :color

  def initialize(name)
    @name = name
    @color = COLOR
  end

  def greet
    puts "Hello!  My name is #{name} and I'm a #{color} cat!"
  end
end

#Identify Yourself (Part 2)
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{name}!"
  end
end

#Public Secret
class Person
  attr_accessor :secret
end

#Private Secret
class Person
  attr_writer :secret
  def share_secret
    puts secret
  end
  private

  attr_reader :secret
end

#Protected Secret
class Person
  attr_writer :secret

  def compare_secret(p2)
    self.secret == p2.secret
  end
  protected

  attr_reader :secret
end