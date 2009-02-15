
def prime?(n)
  return false if n == 1
  return true if n == 2
  return false if n % 2 == 0
  3.step(Math.sqrt(n).to_i, 2) do |i|
    return false if n % i == 0
  end
  return true
end

def primes(n)
  result = [2]
  3.step(n, 2).each do |i|
    result << i if prime?(i)
  end
   result
end

def t
  s = Time.now
  yield
  (Time.now - s).to_i
end

t { primes(250000) } # => 8
