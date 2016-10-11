#Privacy 

class Machine

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  private

  attr_writer :switch
  
  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

#Fixed Array
class FixedArray
  attr_accessor :array, :size
  

  def []=(index, value)
    self.array[index] = value
  end

  def [](index)
    self.array.fetch(index)
  end


  def to_a
    self.array.to_a
  end

  def to_s
    self.array.to_s
  end

  #LS Solution
  # def to_a
  #   @array.clone
  # end
  # def to_s
  #   to_a.to_s
  # end

  def initialize(size)
    @array = Array.new(size) {|index| nil}
  end
end

#Students
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
    def initialize(name, year)
      super(name, year)
    end
end

