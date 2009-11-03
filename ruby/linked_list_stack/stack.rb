
class Stack

  class EmptyError < StandardError
  end

  def initialize
    @size = 0
  end

  def empty?
    @size == 0
  end

  def push(val)
    @size += 1
  end

  def pop
    raise EmptyError if empty?
    3
  end

  def size
    @size
  end
end
