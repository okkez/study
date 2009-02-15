# a

require 'benchmark'

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

def prime_list(n)
  result = [2]
  3.step(n, 2).each do |i|
    result << i if result.all?{|v| i % v != 0 }
  end
  result
end

def prime_memo(memo, n)
  return false if n == 1
  return true if n == 2
  return false if n % 2 == 0
  limit = Math.sqrt(n).to_i
  memo.each{|i|
    if i > limit
      memo << n
      return true
    end
    return false if n % i == 0
  }
  memo << n
  return true
end

def prime_list1a(n)
  memo = []
  2.step(n - 1){|i|
    prime_memo(memo, i)
  }
  memo
end


prime_list(10) # => [2, 3, 5, 7]


def prime_list2(n)
  bt = Array.new(n + 1){ true }
  bt[0] = false
  bt[1] = false
  bt.each_with_index{|v, index|
    d, m = index.divmod(2)
    bt[index] = false if d >= 2 and m == 0
  }
  3.step(Math.sqrt(n).to_i, 2) do |i|
    next unless bt[i]
    bt.each_with_index{|v, index|
      d, m = index.divmod(i)
      bt[index] = false if d >= 2 and m == 0
    }
  end
  result = []
  bt.find_all.with_index{|v, i| result << i if v }
  result
end

def prime_list2a(n)
  bt = Array.new(n + 1){ true }
  bt[0] = false
  bt[1] = false
  result = []
  2.step(n){|i|
    result << i if bt[i]
    i.step(n, i){|k| bt[k] = false }
  }
  result
end

prime_list2(10) # => [2, 3, 5, 7]

primes(100).size      # => 25
prime_list(100).size  # => 25
prime_list2(100).size # => 25

# Benchmark.bmbm{|x|
#   x.report('a'){ primes(100_000) }
#   x.report('b'){ prime_list(100_000) }
#   x.report('c'){ prime_list2(100_000) }
# }

Benchmark.bmbm{|x|
  x.report('a'){ primes(100_000) }
  x.report('b'){ prime_list1a(100_000) }
  x.report('c'){ prime_list2a(100_000) }
}
# >> Rehearsal -------------------------------------
# >> a   1.910000   0.400000   2.310000 (  2.452896)
# >> b   3.460000   0.530000   3.990000 (  4.254464)
# >> c   1.570000   0.310000   1.880000 (  2.015868)
# >> ---------------------------- total: 8.180000sec
# >> 
# >>         user     system      total        real
# >> a   2.220000   0.410000   2.630000 (  2.909615)
# >> b   3.440000   0.510000   3.950000 (  4.227705)
# >> c   1.510000   0.380000   1.890000 (  2.028319)
