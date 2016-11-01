
class CircularBuffer
  def initialize(size)
    @buffer =  []
    @size = size
  end

  def read
    raise BufferEmptyException if @buffer.empty?
    @buffer.shift
  end

  def write(data)
    raise BufferFullException if @buffer.size == @size
    @buffer.push(data) unless data.nil?
  end

  def write!(data)
    return if data.nil?
    if @buffer.size == @size
      @buffer.shift
      @buffer.push(data)
    else
      @buffer.push(data)
    end
  end

  def clear
    @buffer = []
  end
  # Needed Help with these two lines
  class BufferEmptyException < Exception; end
  class BufferFullException < Exception; end
end