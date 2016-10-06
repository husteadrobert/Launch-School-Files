class Student

  attr_accessor :name

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(student)
    self.grade > student.grade
  end


  protected

  attr_accessor :grade

  # def grade
  #   @grade
  # end

  # def grade=(g)
  #   @grade = g
  # end

end

joe = Student.new('Joe', 95)
bob = Student.new('Bob', 80)

puts "Well done!" if joe.better_grade_than?(bob)
