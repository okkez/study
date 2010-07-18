

class Foo
  attr_accessor :a
  def initialize(arr)
    @a = arr
  end
  def dup
    copy = super
    p @a.object_id
    @a = @a.dup
    copy
  end
end

foo = Foo.new([1,2,3])
bar = foo.dup

p [:foo, foo.object_id, foo.a.object_id]
p [:bar, bar.object_id, bar.a.object_id]


