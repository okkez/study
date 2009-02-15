
class Queue1
  def initialize
    @arr = Array.new(100)
    @count = 0
    @iptr = -1
    @optr = 0
  end
  
  def empty?
    @count <= 0
  end
  
  def enq(x)
    return nil if @count + 1 >= @arr.length
    @iptr = (@iptr + 1) % @arr.length
    @arr[@iptr] = x
    @count += 1
    x
  end
  
  def deq
    return if empty?
    x = @arr[@optr]
    @count -= 1
    @optr = (@optr + 1) % @arr.length
    x
  end
end


class Queue2
  
  Data = Struct.new(:data, :next)
  
  def initialize
    @head = @tail = nil
  end
  
  def empty?
    @head.nil?
  end
  
  def enq(x)
    if empty?
      @head = @tail = Data.new(x, nil)
    else
      @tail.next = Data.new(x, nil)
      @tail = @tail.next
    end
  end
  
  def deq
    if @head == @tail
      return nil if empty?
      x = @head.data
      @head  = @tail
      @head = @tail = nil
    else
      x = @head.data
      @head = @head.next
    end
    x
  end
end

def test2(queue)
  loop do
    print '> '
    s = STDIN.gets.chomp
    break if s == 'q'
    if s == ''
      puts queue.deq
    else
      queue.enq(s)
    end
  end
end

# test2(Queue2.new)
