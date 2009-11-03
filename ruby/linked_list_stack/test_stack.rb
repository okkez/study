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
end
