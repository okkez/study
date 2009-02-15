
require 'ex1'

class Buffer
  def initialize
    @a = Stack1.new
    @b = Stack1.new
  end
  
  def eof?
    @b.empty?
  end
  
  def top
    @b.push(@a.pop) until @a.empty?
  end
  
  def forward
    @a.push(@b.pop)
  end
  
  def backward
    @b.push(@a.pop)
  end
  
  def delete
    @b.pop
  end
  
  def insert(s)
    @a.push(s)
  end
  
  def edit(s)
    @b.pop
    @b.push(s)
  end
  
  def go(n)
    top
    n.times do
      forward
    end
  end
  
  def print
    x = @b.pop
    puts x
    @b.push(x)
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
      top
      until @b.empty?
        file.puts @b.pop
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
