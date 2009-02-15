

class Automata
  def initialize(a)
    @a = a
  end
  
  def accept(str)
    cur = 0
    str.chars.each do |c|
      k = @a[cur][c]
      return false if k.nil?
      cur = k
    end
    return @a[cur][:final] == true
  end
end

a = Automata.new([{'a' => 1}, {'b' => 0, :final => true }])

a.accept('aba')   # => true
a.accept('ababa') # => true
a.accept('ab')    # => false
a.accept('abba')  # => false

# a: /\Aa*ba*/
a = Automata.new([{ 'a' => 0, 'b' => 1 },
                  { 'a' => 1, :final => true}])
a.accept('a')  # => false
a.accept('ab') # => true
a.accept('aba') # => true
a.accept('ababa') # => false
a.accept('abba')  # => false
a.accept('abbab')  # => false
a.accept('aaaab')  # => true
a.accept('b') # => true

# b: /\Aa(aa|ba)*/
a = Automata.new([{ 'a' => 1},
                  { 'a' => 2, 'b' => 0, :final => true },
                  { 'a' => 1}])
a.accept('a') # => true
a.accept('ab') # => false
a.accept('aba') # => true
a.accept('abaa') # => false
a.accept('abaaa') # => true
a.accept('aaa') # => true
a.accept('aaaaa') # => true
a.accept('aaaa') # => false



# c: /\Aa(bb)*(aa)*/ FIXME
a = Automata.new([{ 'a' => 1},
                  { 'b' => 2, :final => true},
                  { 'b' => 3},
                  { 'a' => 0, :final => true}])
a.accept('a') # => true
a.accept('ab') # => false
a.accept('abb') # => true
a.accept('abba') # => false
a.accept('abbaa') # => true

# ex6
# a: /a+b/
a = Automata.new([{ 'a' => 1 },
                  { 'a' => 1, 'b' => 2},
                  { :final => true}])

a.accept('ab') # => true
a.accept('aab') # => true
a.accept('aaab') # => true
a.accept('abb') # => false
a.accept('a') # => false
a.accept('b') # => false

# b: /\A[ab]*aa[ab]*/
a = Automata.new([{ 'a' => 1, 'b' => 0, :final => true },
                  { 'a' => 0, 'b' => 1 }])

a.accept('a') # => false
a.accept('aa') # => true
a.accept('baa') # => true
a.accept('aaa') # => false
a.accept('aabaabaabaab') # => true
