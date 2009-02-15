
$hmax = 3
$vmax = 4
$goalx = 1
$goaly = 3
$hsize = [2, 1, 1, 1, 1, 2, 1, 1, 1, 1]
$vsize = [2, 2, 2, 2, 2, 1, 1, 1, 1, 1]
$names = 'Mvvvvwssss.'

def make_board(x, y)
  b = Array.new($vmax + 1){ Array.new($hmax + 1, -1) }
  $hsize.size.times do |i|
    $hsize[i].times do |j|
      $vsize[i].times do |k|
        b[y[i]+k][x[i]+j] = i
      end
    end
  end
  b
end

def movable(b, i, x, y, dx, dy)
  if x + dx < 0 || x + $hsize[i] - 1 + dx > $hmax ||
      y + dy < 0 || y + $vsize[i] - 1 + dy > $vmax
    return false
  end
  $hsize[i].times do |j|
    $vsize[i].times do |k|
      p = b[y + dy + k][x + dx + j]
      if p != -1 && p != i
        return false
      end
    end
  end
  true
end

class State
  
  attr_reader :x, :y
  
  def initialize(x, y, prev)
    @x = x.dup
    @y = y.dup
    @prev = prev
  end
  
  def goal?
    @x[0] == $goalx && @y[0] == $goaly
  end
  
  def move(i, dx, dy)
    @x[i] += dx
    @y[i] += dy
    s = State.new(@x, @y, self)
    @x[i] -= dx
    @y[i] -= dy
    s
  end
  
  def to_s
    s = ''
    make_board(@x, @y).each do |a|
      a.each do |i|
        s << $names[i].chr
      end
      s << "\n"
    end
    s
  end
  
  def output(f)
    @prev.output(f) unless @prev.nil?
    f.puts to_s
    f.puts '------'
  end
end

def main
  x = [1, 0, 3, 0, 3, 1, 0, 1, 2, 3]
  y = [0, 0, 0, 2, 2, 2, 4, 3, 3, 4]
  stack = []
  stack << State.new(x, y, nil)
  visited = { stack[0].to_s => true }
  s = nil
  loop do
    if stack.empty?
      puts 'impossible'
      return false
    end
    s = stack.pop
    # puts s.to_s
    # puts '----'
    break if s.goal?
    x = s.x
    y = s.y
    b = make_board(x, y)
    $hsize.size.times do |i|
      [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |a|
        if movable(b, i, x[i], y[i], a[0], a[1])
          s1 = s.move(i, a[0], a[1])
          k1 = s1.to_s
          if visited[k1].nil?
            stack.push(s1)
            visited[k1] = true
          end
        end
      end
    end
  end
  File.open('out.data', 'w+') do |file|
    s.output(file)
  end
  true
end

main
# >> vMMv
# >> vMMv
# >> vwwv
# >> vssv
# >> s..s
# >> ----
# >> impossible
