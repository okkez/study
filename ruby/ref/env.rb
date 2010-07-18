

class Foo
  def to_str
    "foo"
  end
end

p ENV.index(Foo.new)
p ENV.index(Object.new)
