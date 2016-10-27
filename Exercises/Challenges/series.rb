class Series

  def initialize(string)
    @input_string = string.chars.map(&:to_i)
  end

  def slices(number)
    raise ArgumentError if number > @input_string.length
    counter = number - 1
    start = 0
    all_series = []
    while (start + counter) < @input_string.length
      all_series << @input_string[start..(start+counter)]
      start += 1
    end
    all_series
  end
end
#each_cons(number).to_a would have worked better.