

class Stack1
  def initialize
    @arr = Array.new(100)
    @ptr = -1
  end
  
  def empty?
    @ptr < 0
  end
  
  def push(x)
    @ptr += 1
    @arr[@ptr] = x
  end
  
  def pop
    x = @arr[@ptr]
    @ptr -= 1
    x
  end
end

class Stack2
  Data = Struct.new(:data, :next)
  
  def initialize
    @top = nil
  end
  
  def empty?
    @top.nil?
  end
  
  def push(x)
    @top = Data.new(x, @top)
  end
  
  def pop
    return nil if empty?
    x = @top.data
    @top = @top.next
    x
  end
end

def test1(stack)
  loop do
    print '> '
    s = STDIN.gets.chomp
    break if s == 'q'
    if s == ''
      puts stack.pop
    else
      stack.push(s)
    end
  end
end

# test1(Stack1.new)
# test1(Stack2.new)
