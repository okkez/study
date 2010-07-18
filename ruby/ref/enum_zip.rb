
class Foo
  def to_a
    p :to_a
    []
  end

  def to_ary
    p :to_ary
    []
  end

  def each
    p :each
    yield
  end
end

p [1,2].zip(Foo.new)
p (1..2).zip(Foo.new)
