class PhoneNumber
  def initialize(number)
    @phone_number = validate(number)
  end

  def number
    @phone_number
  end

  def to_s
    "(#{area_code}) #{@phone_number[3..5]}-#{@phone_number[6..9]}"
  end

  def area_code
    @phone_number[0..2]
  end
  
  private
  def validate(number)
    return '0000000000' unless number.scan(/[a-z]/i).empty?
    numbers_only = number.gsub(/[^0-9]/, '')
    numbers_only.slice!(0) if numbers_only.length == 11 && numbers_only[0] == '1'
    return numbers_only if numbers_only.length == 10
    '0000000000'
  end
end
