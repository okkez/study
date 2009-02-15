
class Rational

  attr_reader :dividend, :divisor

  def initialize(dividend, divisor)
    @dividend = dividend
    @divisor = divisor
    return if @divisor == 0
    if @divisor < 0
      @dividend = - @dividend
      @divisor = - @divisor
    end
    if @dividend == 0
      @divisor = 1
    elsif @dividend > 0
      @dividend /= gcd(@dividend, @divisor)
      @divisor /= gcd(@dividend, @divisor)
    end
  end

  def to_s
    "#{@dividend}/#{@divisor}"
  end

  def inspect
    super
  end

  def +(other)
    Rational.new(@dividend * other.divisor + other.dividend * @divisor,
                 @divisor * other.divisor)
  end

  def -(other)
    Rational.new(@dividend * other.divisor - other.dividend * @divisor,
                 @divisor * other.divisor)
  end

  def *(other)
    Rational.new(@dividend * other.dividend,
                 @divisor * other.divisor)
  end

  def /(other)
    Rational.new(@dividend * other.divisor,
                 @divisor * other.dividend)
  end

  private
  def gcd(a, b)
    loop do
      if a > b
        a %= b
        return b if a == 0
      else
        b %= a
        return a if b == 0
      end
    end
  end
  
end


a = Rational.new(3, 5)
b = Rational.new(8, 7)
puts a + b
puts a - b
puts a * b
puts a / b
# >> 61/35
# >> -19/35
# >> 24/35
# >> 21/40
