require 'test/unit'
require 'stack'

class TestStack < Test::Unit::TestCase

  def setup
    @stack = Stack.new
  end

  def test_empty
    assert @stack.empty?
  end
end
