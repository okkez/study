# p.27

def integ2(a, b, n)
  dx = (b - a) / n
  s = 0.0
  n.times do |i|
    x = a + i * (b - a) / n
    y = x ** 2
    s = s + y * dx
  end
  s
end

integ2(1.0, 10.0, 100)   # => 328.55715
integ2(1.0, 10.0, 1000)  # => 332.5546215
integ2(1.0, 10.0, 10000) # => 332.955451214999

# a

def integ2a(a, b, n)
  dx = (b - a) / n
  s = 0.0
  n.times do |i|
    x = a + i * (b - a) / n
    y1 = x ** 2
    y2 = (x + dx) ** 2
    y = (y1 + y2) / 2
    s = s + y * dx
  end
  s
end

integ2a(1.0, 10.0, 100)   # => 333.01215
integ2a(1.0, 10.0, 1000)  # => 333.0001215
integ2a(1.0, 10.0, 10000) # => 333.000001215

# b

def integ2b(a, b, n)
  dx = (b - a) / n
  s = 0.0
  n.times do |i|
    x = a + (i + 0.5) * (b - a) / n
    y = x ** 2
    s = s + y * dx
  end
  s
end

integ2b(1.0, 10.0, 100)   # => 332.993925
integ2b(1.0, 10.0, 1000)  # => 332.99993925
integ2b(1.0, 10.0, 10000) # => 332.999999392501

# c

def integ2c(a, b, n)
  dx = (b - a) / n
  s = 0.0
  n.times do |i|
    x = a + i * (b - a) / n
    y0 = x ** 2
    y1 = (x + 0.5 * dx) ** 2
    y2 = (x + dx) ** 2
    s = s + (y0 + 4 * y1 + y2) * dx / 6.0
  end
  s
end

integ2c(1.0, 10.0, 10)    # => 333.0
integ2c(1.0, 10.0, 100)   # => 333.0
integ2c(1.0, 10.0, 1000)  # => 333.0
integ2c(1.0, 10.0, 10000) # => 333.0
