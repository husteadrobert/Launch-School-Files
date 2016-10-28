class PerfectNumber
  CLASSIFICATION = {deficient: 'deficient', perfect: 'perfect', abundant: 'abundant'}.freeze

  def self.classify(number)
    raise RuntimeError if number < 0
    sum = (1..number-1).to_a.select{|num| number % num == 0}.inject(:+)
    case 
    when sum == number then CLASSIFICATION[:perfect]
    when sum > number then CLASSIFICATION[:abundant]
    when sum < number then CLASSIFICATION[:deficient]
    end
  end
end
