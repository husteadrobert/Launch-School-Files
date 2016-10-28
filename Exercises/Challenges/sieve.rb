class Sieve
  def initialize(num)
    @list = (2..num).to_a
  end

  def primes
    index = 0
    loop do
      multiple_list = find_next_multiples(@list[index])
      index += 1
      previous_size = @list.size
      multiple_list.each do |number|
        @list.delete(number)
      end
      break if previous_size == @list.size
    end
    @list
  end

  private

  def find_next_multiples(counter)
    result = []
    current_num = counter
    while (current_num+counter) <= @list.max
      current_num += counter
      result << current_num
    end
    return result
  end
end