# p.27

# a

def pow2(n)
  r = 1
  n.times do
    r *= 2
  end
  r
end

pow2(0)  # => 1
pow2(1)  # => 2
pow2(10) # => 1024

# b

def fact(n)
  r = 1
  n.times do |i|
    r *= i + 1
  end
  r
end

fact(5) # => 120

# c

def combination(n, r)
  result = 1
  r.times do |i|
    result = result * (n - r + i + 1) / (i + 1)
  end
  result
end

combination(3, 2)  # => 3
combination(6, 3)  # => 20
combination(10, 3) # => 120
combination(10, 1) # => 10

# d

def sin(x, n)
  result = 0
  n.times do |i|
    result += (x ** (2 * i + 1)) / fact(2 * i + 1) * (-1) ** i
  end
  result
end
(3..8).each do |n|
  sin(Math::PI/6, n) # => 0.500002132588792, 0.499999991869023, 0.50000000002028, 0.499999999999964, 0.5, 0.5
end
Math.sin(Math::PI/6) # => 0.5


def cos(x, n)
  result = 0
  n.times do |i|
    result += (x ** (2 * i)) / fact(2 * i) * (-1) ** i
  end
  result
end

(3..8).each do |n|
  cos(Math::PI/3, n)  # => 0.501796201500181, 0.499964565328913, 0.500000433432915, 0.499999996390943, 0.500000000021778, 0.4999999999999
end
Math.cos(Math::PI/3) # => 0.5
