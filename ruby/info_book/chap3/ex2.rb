
def gcd1(x, y)
  while x != y
    if x > y
      x -= y
    else
      y -= x
    end
  end
  x
end

gcd1(2, 3) # =>
gcd1(4, 8) # =>
gcd1(24, 36) # =>
