class Sieve
  def initalize(num)
    @list = (2..num).to_a
  end

  def primes
    #returns array
    prime_list = []
    no_multiples = false
    start_counter = 2
    current_number = 1
    loop do
      while current_number <= num.length
        current_number *= start_counter
        if @list.include?(current_number)
          @list.gsub(current_number, nil)
        start_counter += 1
#Better idea, make an array of each multiple of start_counter up to num.length
#if @list.include?(that_array)
#that_array.each {|number| @list.gsub(num, nil)} or delete


      break if no_multiples
    end




    return prime_list
  end



end