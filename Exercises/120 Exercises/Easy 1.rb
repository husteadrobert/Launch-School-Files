#Banner Class
class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * (@message.length + 2)}+"
  end

  def empty_line
    "|#{' ' * (@message.length + 2)}|"
  end

  def message_line
    "| #{@message} |"
  end
end

#What's the Output?
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.clone.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end
#LS Solution, b/c I only wanted to solve name being mutated.
class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

#Fix the Program - Books (Part 1)
class Book
  attr_reader :title, :author
  
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

#Fix the Program - Books (Part 2)
class Book
  attr_accessor :title, :author
  def to_s
    %("#{title}", by #{author})
  end
end

#Fix the Program - Persons
class Person

  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end
  def first_name=(name)
    @first_name = name.capitalize
  end
  def last_name=(name)
    @last_name = name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

#Fix the Program - Flight Data
class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end
#The database_handle can be accessed outside of this class. Dangerous.

#Buggy Code - Car Mileage
class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

#Rectangles and Squares
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(side)
    @height = side
    @width = side
    #super(side, side)
  end
end

#Complete the Program - Cats!
class Pet
  attr_reader :name, :age
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :color
  def initialize(n,a,color)
    super(n,a)
    @color = color
  end

  def to_s
    "My cat #{self.name} is #{self.age} years old and has #{self.color} fur."
  end
end

#Refactoring Vehicles
class Vehicle
  attr_reader :make, :model
  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end


class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle
  def wheels
    2
  end
end

class Truck
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end