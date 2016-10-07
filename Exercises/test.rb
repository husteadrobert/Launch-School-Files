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


person1 = Person.new
person1.name = 'John Doe'
puts person1.name

