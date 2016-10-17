class RandomClass
  attr_reader :var1, :var2

  def initialize(v1, v2)
    @var1 = v1
    @var2 = v2
  end

  def update(v1)
    self.var1 = v1
  end
end

thing = RandomClass.new(5,10)

thing.update(20)

puts thing.var1