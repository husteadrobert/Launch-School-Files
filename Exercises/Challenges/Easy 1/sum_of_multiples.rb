class SumOfMultiples
  def initialize(*args)
    @list = args
  end

  def self.to(number, list = [3,5])
    return 0 if number < list.min
    result = []
    list.each do |multiple_number|
      current_num = multiple_number
      while current_num < number
        result << current_num
        current_num += multiple_number
      end
    end
    result.uniq.inject(:+)
  end

  def to(number)
    SumOfMultiples.to(number, @list)
  end
end