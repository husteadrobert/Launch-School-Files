class Luhn
  def initialize(input)
    @number = input
  end

  def addends
    array = @number.to_s.chars.map(&:to_i)
    length = array.length
    index = 0
    index += 1 if array.length.odd?
    while index < length
      array[index] = array[index] * 2
      array[index] = array[index] - 9 if array[index] >= 10
      index += 2
    end
    array
  end

  def checksum
    addends.inject(:+)
  end

  def valid?
    (checksum % 10).zero?
  end

  def self.create(input)
    number = input.to_s.chars.push(0).join.to_i
    return number if Luhn.new(number).valid?
    valid_checksum_number = 10 - (Luhn.new(number).checksum % 10)
    result = number.to_s.chars
    result.pop
    result.push(valid_checksum_number)
    result.join.to_i
  end
end

#way better LS solution
  # def self.create(number)
  #   new_base_number = number * 10
  #   if new(new_base_number).valid?
  #     new_base_number
  #   else
  #     luhn_remainder = new(new_base_number).checksum % 10
  #     new_base_number + (10 - luhn_remainder)
  #   end
  # end

  #   def addends
  #   @digits.reverse.each_with_index.map do |digit, index|
  #     if index.even?
  #       digit
  #     else
  #       digit * 2 > 10 ? digit * 2 - 9 : digit * 2
  #     end
  #   end.reverse
  # end