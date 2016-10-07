#Inherited Year
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
end

class Car < Vehicle
end

#Start the Engine (Part 1)
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize(year)
    super
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end

#Only Pass the Year
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  attr_reader :bed_type

  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end

end

class Car < Vehicle
end

#Start the Engine (Part 2)
class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed} please!"
  end
end

#Towable (Part 1)
module Towable
  def tow
    "I can tow a trailer!"
  end
end

class Truck
  include Towable
end

class Car
end

#Towable (Part 2)
module Towable
  def tow
    'I can tow a trailer!'
  end
end

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  include Towable
end

class Car < Vehicle
end

#Method Lookup (Part 1)
# Cat.ancestors yields [Cat, Animal, Object, Kernel, BasicObject]

#Method Lookup (Part 2)
# Cat.ancestors yields [Cat, Animal, Object, Kernel, BasicObject]

#Method Lookup (Part 3)
# Bird.ancestors yields [Bird, Flyable, Animal, Object, Kernel, BasicObject]

#Transportation
module Transportation
  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end
end

Transportation::Truck.new