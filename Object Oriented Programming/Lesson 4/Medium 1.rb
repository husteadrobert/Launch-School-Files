# Question 1
# Ben is correct, because he has the attr_reader :balance

# Question 2
# @quantity lacks a setting method

# Question 3
# this opens quantity to be changed outside of the method

# Question 4

class Greeting
  def greet(string)
    puts "#{string}"
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end

end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# Question 5
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
      @filling_type = "Plain" if @filling_type == nil
      message = ""
      if @glazing == nil
        message << "#{@filling_type}"
      else
        message << "#{@filling_type} with #{@glazing}"
      end
      message
  end
end

# Question 6
# No difference, but first one uses @ instead of self (or nothing)

# Question 7
# remove light from light_information.  So Light.information.