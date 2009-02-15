Pixel = Struct.new(:r, :g, :b)

@image = nil

def init_image
  @image = Array.new(200){
    Array.new(300){
      Pixel.new(255,255,255)
    }
  }
end

def write_image(name)
  File.open(name, 'w') do |file|
    file.puts("P6\n300 200\n255")
    @image.each{|a|
      a.each{|point|
        file.write(point.to_a.pack('ccc'))
      }
    }
  end
end

def selector(x, y, r, g, b, a)
  return unless (0...300).include?(x) and (0...200).include?(y)
  h = { :r => r, :g => g, :b => b }
  h.keys.each do |c|
    @image[y][x][c] = (@image[y][x][c] * a + h[c] * (1.0 - a)).to_i
  end
rescue => e
  p [x, y, r, g, b, a]
  raise e
end

def fill_circle(x, y, rad, r, g, b, a)
  x_min = (x - rad).to_i
  x_max = (x + rad).to_i
  y_min = (y - rad).to_i
  y_max = (y + rad).to_i
  x_min.step(x_max) do |xp|
    y_min.step(y_max) do |yp|
      if (xp - x) ** 2 + (yp - y) ** 2 <= rad ** 2
        selector(xp, yp, r, g, b, a)
      end
    end
  end
end

def fill_rectangle(x, y, w, h, r, g, b, a)
  x.step(x + w) do |xp|
    y.step(y + h) do |yp|
      selector(xp, yp, r, g, b, a)
    end
  end
end

def fill_elipse(x, y, xr, yr, r, g, b, a)
  x_min = (x - xr).to_i
  x_max = (x + xr).to_i
  y_min = (y - yr).to_i
  y_max = (y + yr).to_i
  x_min.step(x_max) do |xp|
    y_min.step(y_max) do |yp|
      if ((xp - x) ** 2) / xr ** 2 + ((yp - y) ** 2) / yr ** 2 <= 1.0
        selector(xp, yp, r, g, b, a)
      end
    end
  end
end

def oprod(a, b, c, d)
  a * b - c * d
end

def inside?(x, y, ax, ay)
  (0...(ax.size - 1)).each do |i|
    return false if oprod(ax[i+1]-ax[i], ay[i+1]-ay[i], x-ax[i], y-ay[i]) < 0
  end
end

def fill_convex(ax, ay, r, g, b, a)
  x_min = ax.min.to_i
  x_max = ax.max.to_i
  y_min = ay.min.to_i
  y_max = ay.max.to_i
  x_min.step(x_max) do |xp|
    y_min.step(y_max) do |yp|
      selector(xp, yp, r, g, b, a) if inside?(xp, yp, ax, ay)
    end
  end
end

def fill_triangle(x0, y0, x1, y1, x2, y2, r, g, b, a)
  fill_convex([x0, x1, x2, x0], [y0, y1, y2, y0], r, g, b, a)
end



def draw_line(x0, y0, x1, y1, w, r, g, b, a)
  vx = y1 - y0
  vy = x1 - x0
  n = 0.5 * w / Math.sqrt(vx ** 2 + vy ** 2)
  vx = vx * n
  vy = vy * n
  fill_convex([x0 - vx, x0 + vx, x1 + vx, x1 - vx, x0 - vx],
              [y0 - vy, y0 + vy, y1 + vy, y1 - vy, y0 - vy], r, g, b, a)
end


def my_picture
  init_image
  fill_circle(150, 30, 60, 255, 100, 70, 0.5)
  fill_circle(190, 100, 30, 100, 200, 80, 0.9)
  fill_circle(10, 10, 10, 100, 100, 80, 0.2)
  fill_rectangle(60, 100, 120, 80, 80, 220, 255, 0.6)
  fill_elipse(200, 60, 70, 40, 100, 100, 220, 0.3)
  fill_triangle(200, 100, 300, 100, 250, 200, 200, 100, 250, 0.4)
  draw_line(40, 40, 260, 160, 4, 0, 0, 0, 0.0)
  write_image('t.ppm')
end

my_picture
