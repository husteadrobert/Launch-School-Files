#Reading and Writing
class Person
  #attr_accessor :name
  def name
    @name
  end
  def name=(n)
    @name = n
  end
end

#Choose the Right Method
class Person
  attr_reader :name
  attr_writer :name, :phone_number
end

#Access Denied
class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end

  private

  attr_writer :phone_number
end

#Comparing Names
class Person
  attr_writer :first_name, :last_name
  attr_reader :first_name
  def first_equals_last?
    first_name == last_name
  end
  private
  attr_reader :last_name
end

#Who is Older?
class Person
  attr_writer :age
  def older_than?(other)
    age > other.age
  end

  protected
  attr_reader :age
end

#Guaranteed Formatting
class Person
  attr_reader :name
  def name=(n)
    @name = n.capitalize
  end
end

#Prefix the Name
class Person
  def name
    "Mr. #{@name}"
  end
  attr_writer :name
end

#Avoid Mutatoin
class Person
  def initialize(name)
    @name = name
  end

  def name
    @name.clone
  end
end

#Calculated Age
class Person
  def age=(a)
    @age = a *2
  end
  def age
    @age * 2
  end
end

#Extra LS Stuff
class Person
  def age=(age)
    @age = double(age)
  end

  def age
    double(@age)
  end

  private

  def double(value)
    value * 2
  end
end

#Unexpected Change
class Person
  attr_accessor :name
  def name=(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.last
    #@first_name, @last_name = full_name.split(' ')
  end
  def name
    "#{@first_name} #{@last_name}"
  end
end