
class Node
  
  attr_reader :left, :right, :op
  
  def initialize(left = nil, right = nil)
    @left = left
    @right = right
    @op = '?'
  end
  
  def to_s
    "(#{@left.to_s} #{@op.to_s} #{@right.to_s})" # !> instance variable @right not initialized
  end
end

class Add < Node
  def initialize(left, right)
    super
    @op = '+'
  end
  
  def exec
    @left.exec + @right.exec
  end
end

class Sub < Node
  def initialize(left, right)
    super
    @op = '-'
  end
  
  def exec
    @left.exec - @right.exec
  end
end

class Mul < Node
  def initialize(left, right)
    super
    @op = '*'
  end
  
  def exec
    @left.exec * @right.exec
  end
end

class Div < Node
  def initialize(left, right)
    super
    @op = '/'
  end
  
  def exec
    @left.exec / @right.exec
  end
end

class Mod < Node
  def initialize(left, right)
    super
    @op = '%'
  end
  
  def exec
    @left.exec % @right.exec
  end
end

class Literal < Node
  def initialize(left)
    @left = left
    @op = '#'
  end
  
  def exec
    @left
  end
end

class Variable < Node
  @@vars = {}
  
  def initialize(left)
    @left = left
    @op = '$'
  end
  
  def exec
    @@vars[@left]
  end
  
  def self.vars
    @@vars
  end
end

class Assign < Node
  def initialize(left, right)
    super
    @op = '='
  end
  
  def exec
    v = @right.exec
    Variable.vars[@left.left] = v
    v
  end
end

class Seq < Node
  def initialize(left, right)
    super
    @op = ';'
  end
  
  def exec
    @left.exec
    @right.exec
  end
end

class Loop < Node
  def initialize(left, right)
    super
    @op = 'L'
  end
  
  def exec
    v = nil
    @left.exec.times do
      v = @right.exec
    end
    v
  end
end


class Noop < Node
  def initialize
    super
  end
  
  def exec
    0
  end
  
  def to_s
    '?'
  end
end


class Eq < Node
  def initialize(left, right)
    super
    @op = '=='
  end
  
  def exec
    if @left.exec == @right.exec
      1
    else
      0
    end
  end
end

class Le < Node
  def initialize(left, right)
    super
    @op = '<='
  end
  
  def exec
    if @left.exec <= @right.exec
      1
    else
      0
    end
  end
end

class Lt < Node
  def initialize(left, right)
    super
    @op = '<'
  end
  
  def exec
    if @left.exec < @right.exec
      1
    else
      0
    end
  end
end


class If < Node
  def initialize(left, right)
    super
    @op = 'I'
  end
  
  def exec
    if @left.exec != 0
      @right.exec
    end
  end
end

class While < Node
  def initialize(left, right)
    super
    @op = 'W'
  end
  
  def exec
    while @left.exec != 0
      @right.exec
    end
  end
end

class Read < Node
  def initialize
    super
    @op = 'R'
  end
  
  def exec
    print '> '
    STDIN.gets.to_i
  end
end

class Write < Node
  
  def initialize(left)
    super
    @op = 'W'
  end
  
  def exec
    puts @left.exec
  end
end

class Print < Node
  
  def initialize(left)
    super
    @op = 'W'
  end
  
  def exec
    puts @left.exec
  end
end


def test1
  e = Seq.new(Assign.new(Variable.new('n'), Literal.new(5)),
              Seq.new(Assign.new(Variable.new('x'), Literal.new(1)),
                      Seq.new(Loop.new(Variable.new('n'),
                                       Seq.new(Assign.new(Variable.new('x'),
                                                          Mul.new(Variable.new('x'),
                                                                  Variable.new('n'))),
                                               Assign.new(Variable.new('n'),
                                                          Sub.new(Variable.new('n'),
                                                                  Literal.new(1))))),
                                       Variable.new('x'))))
  puts e
  p e.exec
end

test1
# >> (((n $ ) = (5 # )) ; (((x $ ) = (1 # )) ; (((n $ ) L (((x $ ) = ((x $ ) * (n $ ))) ; ((n $ ) = ((n $ ) - (1 # ))))) ; (x $ ))))
# >> 120
