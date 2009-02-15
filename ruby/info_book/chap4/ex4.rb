

def fact(n)
  return 1 if n == 0
  n * fact(n - 1)
end

fact(10) # => 3628800

def fib(n)
  return 1 if n == 0 or n == 1
  fib(n - 1) + fib(n - 2)
end

fib(10) # => 89

def comb(n, r)
  return 1 if r == 0 or r == n
  comb(n - 1, r) + comb(n - 1, r - 1)
end

comb(10, 3) # => 120

def binary(n)
  return '0' if n == 0
  return '1' if n == 1
  if n % 2 == 0
    "#{binary(n / 2)}0"
  else
    "#{binary(n / 2)}1"
  end
end

binary(10) # => "1010"
binary(3)  # => "11"
