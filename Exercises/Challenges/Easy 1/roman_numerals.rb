class Fixnum
  SYMBOLS = {1 => "I",
             4 => "IV",
             5 => "V",
             9 => "IX",
             10 => "X",
             40 => "XL",
             50 => "L",
             90 => "XC",
             100 => "C",
             400 => "CD",
             500 => "D",
             900 => "CM",
             1000 => "M"}
  def to_roman
    number = self.to_s.chars.map(&:to_i)
    while number.size < 4
      number.unshift(0)
    end
    result = ''
    result << (SYMBOLS[1000] * number[0])
    current_spot = 100
    number[1..-1].each do |spot|
      case spot
      when 1, 2, 3 then result << (SYMBOLS[current_spot] * spot)
      when 4 then result << SYMBOLS[4*current_spot]
      when 5 then result << SYMBOLS[5*current_spot]
      when 6, 7, 8 then result << SYMBOLS[5*current_spot] << SYMBOLS[current_spot] * (spot - 5)
      when 9 then result << SYMBOLS[9*current_spot]
      end
      current_spot /= 10
    end
    result
  end
end