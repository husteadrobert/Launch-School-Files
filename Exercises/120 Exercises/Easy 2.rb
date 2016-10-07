#Fix the Program - Mailable
module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

#Fix the Program - Drivable
module Drivable
  def drive
  end
end

class Car
  include Drivable
end

#Complete the Program - Houses
class House
  attr_reader :price
  include Comparable

  def <=>(other)
    price <=> other.price
  end

  def initialize(price)
    @price = price
  end
end

#Reverse Engineering
class Transform
  def initialize(string)
    @var = string
  end

  def uppercase
    @var.upcase
  end

  def self.lowercase(string)
    string.downcase
  end
end

# What Will This Do?
#"ByeBye"
#"HelloHello"

#Comparing Wallets
class Wallet
  include Comparable
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected
  attr_reader :amount
end

#Pet Shelter
class Pet
  attr_reader :name, :type
  def initialize(type, name)
    @type = type
    @name = name
  end
  def to_s
    "a #{@type} named #{@name}"
  end
end

class Owner
  attr_accessor :pets, :number_of_pets
  attr_reader :name
  def initialize(name)
    @name = name
    @pets = []
    @number_of_pets = 0
  end
end

class Shelter
  attr_reader :owner_list
  def initialize
    @owner_list = []
  end

  def adopt (owner, pet)
    owner_list << owner unless owner_list.include?(owner)
    owner.pets << pet
    owner.number_of_pets += 1
  end
  def print_adoptions
    owner_list.each do |owner|
      puts "#{owner.name} has addopted the following pets:"
      owner.pets.each do |pet|
        puts pet
      end
      puts ""
    end
  end
end

#Fix the Program - Expander
class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end
#can't call self.method on a private method.

#Moving
module Moveable
  def walk
    puts "#{self.name} #{gait} forward"
  end
end


class Person
  include Moveable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end


class Cat
  include Moveable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Moveable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

#Nobility
module Moveable
  def walk
    puts "#{name} #{gait} forward"
  end
end


class Person
  include Moveable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title
  def initialize(name, title)
    super(name)
    @title = title
  end

  def name
    "#{@title} #{@name}"
  end

  private
  def gait
    "struts"
  end
end

class Cat
  include Moveable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Moveable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

#Could also do this with #{self} in the Moveable, and include a to_s definition in each
