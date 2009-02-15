

class Complex
  
  attr_reader :real, :imaginary
  protected :real, :imaginary
  
  def initialize(real, imaginary)
    @real = real
    @imaginary = imaginary
  end
  
  def to_s
    "#{@real} #{@imaginary >= 0 ? '+' : '-'} #{@imaginary.abs}i"
  end
  
  def +(other)
    Complex.new(@real + other.real, @imaginary + other.imaginary)
  end
  
  def -(other)
    Complex.new(@real - other.real, @imaginary - other.imaginary)
  end
  
  def *(other)
    Complex.new(@real * other.real - @imaginary * other.imaginary,
                @imaginary * other.real + @real * other.imaginary)
  end
  
  def /(other)
    n = (other.real ** 2 + other.imaginary ** 2).to_f
    Complex.new((@real * other.real + @imaginary * other.imaginary) / n,
                (@imaginary * other.real - @real * other.imaginary) / n)
  end

end


a = Complex.new(1, 2)
b = Complex.new(2, 1)

puts a + b
puts a - b
puts b - a
puts a * b
puts a / b
# >> 3 + 3i
# >> -1 + 1i
# >> 1 - 1i
# >> 0 + 5i
# >> 0.8 + 0.6i
