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
    Seq.new(s, prog(sc)) # !> instance variable @right not initialized
  else
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
      Noop.new
    else
      sc.fwd
      p
    end
  when 'W'
    sc.fwd
    e = asn(sc)
    While.new(e, stat(sc))
  when 'I'
    sc.fwd
    e = asn(sc)
    If.new(e, stat(sc))
  when 'P'
    sc.fwd
    e = asn(sc)
    Print.new(e)
  else
    asn(sc)
  end
end

def asn(sc)
  e = cmp(sc)
  c = sc.peek
  if c == '='
    sc.fwd
    return Assign.new(e, asn(sc))
  else
    e
  end
end

def cmp(sc)
  e = expr(sc)
  c = sc.peek
  case c
  when '<'
    sc.fwd
    Lt.new(e, cmp(sc))
  when '<='
    sc.fwd
    Le.new(e, cmp(sc))
  when '>'
    sc.fwd
    Gt.new(e, cmp(sc))
  when '>='
    sc.fwd
    Ge.new(e, cmp(sc))
  when '=='
    sc.fwd
    Eq.new(e, cmp(sc))
  when '!='
    sc.fwd
    Ne.new(e, cmp(sc))
  else
    e
  end
end

def expr(sc)
  e = term(sc)
  expr1(e, sc)
end

def expr1(e, sc)
  c = sc.peek
  case c
  when '+'
    sc.fwd
    e1 = term(sc)
    expr1(Add.new(e, e1), sc)
  when '-'
    sc.fwd
    e1 = term(sc)
    expr1(Sub.new(e, e1), sc)
  else
    e
  end
end

def term(sc)
  e = fact(sc)
  term1(e, sc)
end

def term1(e, sc)
  c = sc.peek
  case c
  when '*'
    sc.fwd
    e1 = term(sc)
    term1(Mul.new(e, e1), sc)
  when '/'
    sc.fwd
    e1 = term(sc)
    term1(Div.new(e, e1), sc)
  when '%'
    sc.fwd
    e1 = term(sc)
    term1(Mod.new(e, e1), sc)
  else
    e
  end
end

def fact(sc)
  c = sc.peek
  sc.fwd
  case c
  when 'a'
    Variable.new(sc.str)
  when '0'
    Literal.new(sc.str.to_i)
  when '('
    e = asn(sc)
    unless sc.peek == ')'
      puts "NO_): #{sc.to_s}"
      Noop.new
    else
      sc.fwd
      e
    end
  when 'R'
    Read.new
  else
    puts "FACTOR: #{c} #{sc.to_s}"
    Noop.new
  end
end

tree = prog(FileLexer.new('test.prog'))
tree.to_s # => "(((max $ ) = ( R )) ; (((n $ ) = (2 # )) ; (((n $ ) <= (max $ )) W (((i $ ) = (2 # )) ; (((sosu $ ) = (1 # )) ; ((((i $ ) < (n $ )) W (((((n $ ) % (i $ )) == (0 # )) I ((sosu $ ) = (0 # ))) ; ((i $ ) = ((i $ ) + (1 # ))))) ; (((sosu $ ) I ((n $ ) W )) ; ((n $ ) = ((n $ ) + (1 # ))))))))))"
tree.exec
