
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

def fill_circle(x, y, rad, r, g, b)
  200.times do |j|
    300.times do |i|
      if (i - x) ** 2 + (j - y) ** 2 < rad ** 2
        @image[j][i].r = r
        @image[j][i].g = g
        @image[j][i].b = b
      end
    end
  end
end


def my_picture
  init_image
  fill_circle(150, 30, 60, 255, 100, 70)
  fill_circle(190, 100, 30, 100, 200, 80)
  fill_circle(10, 10, 10, 100, 100, 80)
  write_image('t.ppm')
end

my_picture
