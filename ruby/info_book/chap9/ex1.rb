

class Add
  def initialize(left, right)
    @left = left
    @right = right
  end
  
  def exec
    @left.exec + @right.exec
  end
  
  def to_s
    "(#{@left} + #{@right})"
  end
end

class Multiple
  def initialize(left, right)
    @left = left
    @right = right
  end
  
  def exec
    @left.exec * @right.exec
  end
  
  def to_s
    "(#{@left} * #{@right})"
  end
end

class Sub
  def initialize(left, right)
    @left = left
    @right = right
  end
  
  def exec
    @left.exec - @right.exec
  end
  
  def to_s
    "(#{@left} - #{@right})"
  end
end

class Div
  def initialize(left, right)
    @left = left
    @right = right
  end
  
  def exec
    @left.exec / @right.exec
  end
  
  def to_s
    "(#{@left} / #{@right})"
  end
end

class Literal
  def initialize(v)
    @left = v
  end
  
  def exec
    @left
  end
  
  def to_s
    @left.to_s
  end
end

class Variable
  @@vars = { }
  
  def initialize(v)
    @left = v
  end
  
  def exec
    @@vars[@left]
  end
  
  def to_s
    @left.to_s
  end
  
  def self.vars
    @@vars
  end
end

class Output
  def initialize(v)
    @left = v
  end
  
  def exec
    result = @left.exec
    puts result
    result
  end
  
  def to_s
    @left.to_s
  end
end

class Input
  def initialize
  end
  
  def exec
    print '> '
    STDIN.gets.chomp.to_i
  end
  
  def to_s
    'input node'
  end
end

class Sequence
  def initialize(left, right)
    @left = left
    @right = right
  end
  
  def exec
    @left.exec
    @rigth.exec
  end
  
  def to_s
    'sequence node'
  end
end

def Loop
  def initialize(left, right)
    @left = left
    @right = right
  end
  
  def exec
    result = nil
    @left.exec.times do
      result = @right.exec
    end
    result
  end
end

def test
  Variable.vars['x'] = 5
  e = Add.new(Variable.new('x'), Literal.new(1))
  puts e.to_s + ' : ' + e.exec.to_s
  e = Add.new(Literal.new(3),
              Multiple.new(Variable.new('x'), Literal.new(2)))
  puts e.to_s + ' : ' + e.exec.to_s
  e = Multiple.new(Add.new(Variable.new('x'), Literal.new(3)), Literal.new(2))
  puts e.to_s + ' : ' + e.exec.to_s
  e = Sub.new(Literal.new(3),
              Multiple.new(Variable.new('x'), Literal.new(2)))
  puts e.to_s + ' : ' + e.exec.to_s
  e = Sub.new(Literal.new(3),
              Div.new(Variable.new('x'), Literal.new(2)))
  puts e.to_s + ' : ' + e.exec.to_s
end

test
# >> (x + 1) : 6
# >> (3 + (x * 2)) : 13
# >> ((x + 3) * 2) : 16
# >> (3 - (x * 2)) : -7
# >> (3 - (x / 2)) : 1
