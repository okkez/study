require 'ex3'
require 'ex4'

def prog(sc)
  s = stat(sc)
  c = sc.peek
  case c
  when '$', '}'
    s
  when ';'
    sc.fwd
    Seq.new(s, prog(sc))
  else # !> instance variable @right not initialized
    puts "STAT: #{sc.to_s}"
    Noop.new
  end
end

def stat(sc)
  c = sc.peek
  case c
  when '{'
    sc.fwd
    p = prog(sc)
    unless sc.peek == '}'
      puts "NO_}: #{sc.to_s}"
      return Noop.new
    end
    sc.fwd
    return p
  when 'L'
    sc.fwd
    e = expr(sc)
    return Loop.new(e, stat(sc))
  else
    expr(sc)
  end
end

def expr(sc)
  e = fact(sc)
  c = sc.peek
  case c
  when '+'
    sc.fwd
    Add.new(e, expr(sc))
  when '-'
    sc.fwd
    Sub.new(e, expr(sc))
  when '*'
    sc.fwd
    Mul.new(e, expr(sc))
  when '/'
    sc.fwd
    Div.new(e, expr(sc))
  when '='
    sc.fwd
    Assign.new(e, expr(sc))
  else
    e
  end
end

def fact(sc)
  c = sc.peek
  sc.fwd
  case c
  when /\A[a-z]\z/
    Variable.new(c)
  when /\A[0-9]\z/
    Literal.new(c.to_i)
  when '('
    e = expr(sc)
    unless sc.peek == ')'
      puts "NO_): #{sc.to_s}"
      return Noop.new
    end
    sc.fwd
    e
  else
    puts "FACTOR: #{sc.to_s}"
    Noop.new
  end
end


def test2
  e = prog(Lexer.new('n=5;x=1;L5{x=x*n;n=n-1};x'))
  puts e
  puts e.exec
end

test2
# >> (((n $ ) = (5 # )) ; (((x $ ) = (1 # )) ; (((n $ ) L (((x $ ) = ((x $ ) * (n $ ))) ; ((n $ ) = ((n $ ) - (1 # ))))) ; (x $ ))))
# >> 120
# >> x=x+1!$
# >> (((n $ ) = (5 # )) ; (((x $ ) = (1 # )) ; (((5 # ) L (((x $ ) = ((x $ ) * (n $ ))) ; ((n $ ) = ((n $ ) - (1 # ))))) ; (x $ ))))
# >> 120
