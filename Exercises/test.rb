# require 'pry'

# class CircularQueue
#   attr_accessor :queue
#   def []=(index, value)
#     self.queue[index] = value
#   end

#   def [](index)
#     self.queue[index]
#   end

#   @@current_queue_index = 0
#   @@current_dequeue_index = 0

#   def initialize(size)
#     @queue = Array.new(size)
#   end

#   def empty?
#     result = self.queue.select {|element| element == nil}
#     result.size == queue.size
#   end

#   def full_queue?
#     result = self.queue.select {|element| element == nil}
#     result.size == 0
#   end

#   def dequeue
#     binding.pry
#     return nil if empty?
#     current_element = self.queue[@@current_dequeue_index]
#     self.queue[@@current_dequeue_index] = nil
#     @@current_dequeue_index += 1
#     if @@current_dequeue_index == self.queue.size
#       @@current_dequeue_inex = 0
#     end
#     binding.pry
#     return current_element
#   end

#   def enqueue(value)
#     if full_queue?
#       @@current_dequeue_index = @@current_queue_index
#     end
#     # @@current_dequeue_index += 1 if self.queue[@@current_queue_index] == nil
#     # if @@current_dequeue_index == self.queue.size
#     #   @@current_dequeue_inex = 0
#     # end
#     self.queue[@@current_queue_index] = value
#     @@current_queue_index += 1
#     if @@current_queue_index == self.queue.size
#       @@current_queue_index = 0
#     end
#     #binding.pry
#   end

#   def to_s
#     self.queue.to_s
#   end

# end
class CircularQueue
  def initialize(size)
    @buffer = [nil] * size
    @next_position = 0
    @oldest_position = 0
  end

  def enqueue(object)
    unless @buffer[@next_position].nil?
      @oldest_position = increment(@next_position)
    end

    @buffer[@next_position] = object
    @next_position = increment(@next_position)
  end

  def dequeue
    value = @buffer[@oldest_position]
    @buffer[@oldest_position] = nil
    @oldest_position = increment(@oldest_position) unless value.nil?
    value
  end

  private

  def increment(position)
    (position + 1) % @buffer.size
  end
end



queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1


queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil


#push and shift