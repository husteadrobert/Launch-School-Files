class DNA
  def initialize(sequence)
    @sequence = sequence
  end

  def hamming_distance(other_sequence)
    total = 0
    0.upto(@sequence.length - 1) do |index|
      total += 1 unless @sequence[index] == other_sequence[index]
      break if index >= (other_sequence.size - 1)
    end
    total
  end
end
