
class Stack

  class EmptyError < StandardError
  end

  class Node
    attr_accessor :prev, :data
    def initialize(prev, data)
      @prev = prev
      @data = data
    end
  end

  def initialize
    @top = nil
    @size = 0
  end

  def empty?
    @size == 0
  end

  def push(val)
    @size += 1
    node = Node.new(@top, val)
    @top = node
    val
  end

  def pop
    raise EmptyError if empty?
    @size -= 1
    popped = @top
    @top = @top.prev
    popped.data
  end

  def size
    @size
  end
end
