#Needed help with this line
class InvalidCodonError < StandardError; end

class Translation
  def self.of_codon(codon)
    return 'STOP' if is_stop?(codon)
    translate_sequence(codon)
  end

  def self.of_rna(rna_strand)
    raise InvalidCodonError if rna_strand =~ /[^AUCG]/
    result = []
    while !(rna_strand.empty?)
      codon = rna_strand.slice!(0, 3)
      break if is_stop?(codon)
      result << translate_sequence(codon)
    end
    result
  end

  def self.translate_sequence(nucleotide_sequence)
    case nucleotide_sequence
    when 'AUG' then 'Methionine'
    when 'UUU', 'UUC' then 'Phenylalanine'
    when 'UUA', 'UUG' then 'Leucine'
    when 'UCU', 'UCC', 'UCA', 'UCG' then 'Serine'
    when 'UAU', 'UAC' then 'Tyrosine'
    when 'UGU', 'UGC' then 'Cysteine'
    when 'UGG' then 'Tryptophan'
    end
  end

  def self.is_stop?(nucleotide_sequence)
    nucleotide_sequence == 'UAA' ||
    nucleotide_sequence == 'UAG' ||
    nucleotide_sequence == 'UGA'
  end
end
