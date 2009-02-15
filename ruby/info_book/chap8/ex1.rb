

class Buffer
  Cell = Struct.new(:data, :next)
  
  attr_reader :lineno
  
  def initialize
    @tail = @cur = Cell.new('[EOF]', nil)
    @head = @prev = Cell.new('', @cur)
    @lineno = 1
  end
  
  def eof?
    @cur == @tail
  end
  
  def top
    @prev = @head
    @cur = @head.next
    @lineno = 1
  end
  
  def forward
    return if eof?
    @prev = @cur
    @cur = @cur.next
    @lineno += 1
  end
  
  def insert(s)
    @prev.next = Cell.new(s, @cur)
    @prev = @prev.next
    @lineno += 1
  end
  
  def edit(s)
    return if eof?
    @cur.data = s
  end
  
  def delete
    return if eof?
    @cur = @cur.next
    @prev.next = @cur
  end
  
  def exchange
    return if eof? or @cur.next == @tail
    a = @prev
    b = @cur.next
    c = @cur
    d = @cur.next.next
    a.next = b
    b.next = c
    c.next = d
    @cur = b
  end
  
  def backward
    return if @prev == @head
    @cur = @prev
    @lineno -= 1 if @lineno > 1
  end
  
  def go(n)
    top
    (n - 1).times do
      forward
    end
  end
  
  def invert
    top
    return if eof?
    a = @cur
    b = @cur.next
    a.next = @tail
    until b == @tail
      c = b.next
      b.next = a
      a = b
      b = c
    end
    @head.next = a
    top
  end
  
  def print
    puts "#{@lineno}: #{@cur.data}"
  end
  
  def each(&block)
    top
    until eof?
      block.call @cur
      forward
    end
    top
  end
  
  def read(filename)
    File.open(filename, 'r') do |file|
      file.readlines.each do |line|
        insert(line)
      end
    end
  end
  
  def save(filename)
    File.open(filename, 'w') do |file|
      each do |v|
        file.puts v.data
      end
    end
  end
end

def main
  e = Buffer.new
  loop do
    print '> '
    line = STDIN.gets.chomp
    command = line[0].chr unless line.empty?
    str = line[1..-1]
    case command
    when 'q'
      return
    when 't'
      e.top
      e.print
    when 'p'
      if /\d+/ =~ str
        org = e.lineno
        if str == '0'
          e.each do |v|
            e.print
          end
        else
          e.print
          str.to_i.times do
            e.forward
            e.print
          end
        end
        e.go(org)
      else
        e.print
      end
    when 'i'
      e.insert(str)
    when 'a'
      e.forward
      e.insert(str)
      e.backward
    when 'e'
      e.print
      e.edit(str)
      e.print
    when 'g'
      e.go(str.to_i)
    when 'r'
      e.read(str)
    when 'w'
      e.save(str)
    when 's'
      e.subst(str)
      e.print
    when 'd'
      e.delete
    else
      e.forward
      e.print
    end
  end
end

if __FILE__ == $0
  main
end
