# class Person
#   attr_accessor :first_name, :last_name


#   def initialize(n)
#     parse_full_name(n)
#   end

#   def name
#     "#{self.first_name} #{self.last_name}".strip
#   end

#   def name=(full_name)
#     parse_full_name(full_name)
#   end

#   def to_s
#     name
#   end

#   private

#   def parse_full_name(full_name)
#     parts = full_name.split
#     self.first_name = parts.first
#     self.last_name = parts.size > 1 ? parts.last : ''
#   end

# end

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  

class Cat < Pet
  def speak
    'meow!'
  end
end



bull = Dog.new
p bull.swim   
p bull.speak

demon = Cat.new
p demon.jump
p demon.swim