# Listening Device
class Device
  def initialize
    @recordings = []
  end

  def listen
    record(yield) if block_given?
  end
  def record(recording)
    @recordings << recording
  end

  def play
    puts "#{@recordings.last}"
  end
end

# Text Analyzer - Sandwich Code
class TextAnalyzer
  def process
    whole_text = ""
    f = File.open("random.txt", "r")
    f.each_line do |line|
      whole_text << line
    end
    yield(whole_text)
    f.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |file| puts "#{whole_text.split("\n\n").count} paragraphs"}
analyzer.process { |file| puts "#{whole_text.split("\n").count} lines"}
analyzer.process { |file| puts "#{whole_text.split(' ').count} lines"}

#LS Solution
class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r')
    yield(file.read)
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
analyzer.process { |text| puts "#{text.split("\n").count} lines" }
analyzer.process { |text| puts "#{text.split(' ').count} words" }

# Passing Parameters Part 1
def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Lets start gathering food."
end

gather(items) {puts "#{items.join('; ')}"}

# Passing Parameters Part 2
#LS Solution
birds = ['crow', 'finch', 'hawk', 'eagle']

def types(birds)
  yield birds
end

types(birds) do |_,_,*birds_of_prey|
  puts "Two birds of prey are the #{birds_of_prey.join(' and ')}."
end

# Passing Parameters Part 3
# 1
gather(items) do |*items , wheat|
  puts "#{items.join(', ')}"
  puts "#{wheat}"
end
# 2
gather(items) do |apples , *items , wheat |
  puts "#{apples}"
  puts "#{items.join(', ')}"
  puts "#{wheat}"
end
# 3
gather(items) do |apples , *items|
  puts "#{apples}"
  puts "#{items.join(', ')}"
end
# 4
gather(items) do | apples, corn, cabbage, wheat|
  puts "#{apples}, #{corn}, #{cabbage}, #{wheat}"
end

# Exploring Procs, Lambdas, and Blocks: Definition and Arity
# Procs/Blocks do not enforce the number of arguments, Lamdas do.
# Lamdas are a type of Proc.
# If a yield does not pass over enough arguments to initalize all block variables, the remaining
# ones are nil.
# If there is a yield without a block, an error is thrown.

# Exploring Procs, Lambdas, and Blocks: Returning
# Procs/Blocks are strange with return.  The return will kick out of a method if the block is defined within a method.
# the return will be an error if the Proc/Block is defined outside of a method.
# Lambdas act as their own scope, it seems, as return does not effect the rest of methods.

# Method to Proc
#LS Solution
def convert_to_base_8(n)
  n.to_s(8).to_i
end

base8_proc = method(:convert_to_base_8).to_proc

[8,10,12,14,16,33].map(&base8_proc) # => [10, 12, 14, 16, 20, 41]

# Internal vs External Iterators


# Bubble Sort with Blocks
def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index - 1] <= array[index]
      end
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end
    break unless swapped
  end
  nil
end