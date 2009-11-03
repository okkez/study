require 'test/unit'
require 'stack'

class TestStack < Test::Unit::TestCase

  def setup
    @stack = Stack.new
  end

  def test_empty
    assert @stack.empty?
  end

  def test_push_and_pop
    @stack.push(3)
    assert_equal 3, @stack.pop
  end

  def test_push_and_size
    @stack.push(3)
    assert_equal 1, @stack.size
  end

  def test_push_push_and_size
    @stack.push(3)
    @stack.push(5)
    assert_equal 2, @stack.size
  end

end
