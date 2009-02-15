
class Lexer
  def initialize(s)
    @str = s + '$'
    @pos = 0
  end
  
  def peek
    @str[@pos].chr
  end
  
  def fwd
    @pos += 1 unless @pos > @str.length - 1
  end
  
  def to_s
    "#{@str[0..@pos-1]}!#{@str[@pos..-1]}"
  end
end

sc = Lexer.new('x=x+1')
sc.peek # => "x"
sc.fwd  # => 1
sc.peek # => "="
sc.fwd  # => 2
sc.fwd  # => 3
sc.fwd  # => 4
sc.peek # => "1"
sc.fwd  # => 5
sc.peek # => "$"
# puts sc


class FileLexer
  
  attr_reader :str
  
  def initialize(filename)
    @file = File.open(filename, 'r')
    @line = ''
    @str = ''
    @pos = 0
    @lineno = 0
    @cur = '$'
    self.fwd
  end
  
  def peek
    @cur
  end
  
  def to_s
    "line #{@lineno}: char #{@pos} in #{@line}"
  end
  
  def fwd
    until @line. nil?
      if @pos >= @line.length
        @line = @file.gets
        @pos = 0
        @lineno += 1
        next
      end
      c = @line[@pos].chr
      l = @line.length
      case c
      when /\A\s\z/
        @pos += 1
        next
      when /\A[0-9]\z/
        pos = @pos + 1
        while pos < l && /\A[0-9]\z/ =~ @line[pos].chr
          pos += 1
        end
        @cur = '0'
        @str = @line[@pos..pos-1]
        @pos = pos
        return
      when /\A[a-zA-Z]\z/
        pos = @pos + 1
        while pos < l && /\A[a-zA-Z]\z/ =~ @line[pos].chr
          pos += 1
        end
        @str = @line[@pos..pos-1]
        @pos = pos
        @cur = case @str
               when 'while'
                 'W'
               when 'if'
                 'I'
               when 'print'
                 'P'
               when 'read'
                 'R'
               else
                 'a'
               end
        return
      else
        @cur = c
        @pos += 1
        if /\A[=<>!]\z/ =~ c && @pos < l && @line[@pos].chr == '='
          @cur += '='
          @pos += 1
        end
        return
      end
    end
    @cur = '$'
  end
end


sc = FileLexer.new('test.prog')
sc.peek # => nil
sc.str  # => "max"
sc.fwd  # => nil
sc.peek # => "="
sc.fwd  # => nil
sc.peek # => "R"

# >> x=x+1!$
