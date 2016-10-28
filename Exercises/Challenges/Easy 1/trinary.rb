class Trinary
  def initialize(number)
    @number = number
  end

  def to_decimal
    digits = @number.chars
    return 0 if digits.any? {|digit| digit =~ /[^0-3]/}
    result = 0
    raise_to = digits.size - 1
    digits.each do |digit|
      result += digit.to_i * (3**raise_to)
      raise_to -= 1
    end
    result
  end
end