class Octal
  def initialize(number)
    @number = number
  end

  def to_decimal
    return 0 if @number.chars.any? {|digit| digit =~ /[^0-7]/}
    result = 0
    raise_to = @number.size - 1
    @number.chars.each do |digit|
      result += digit.to_i*(8**raise_to)
      raise_to -= 1
    end
  result
  end
end