require 'benchmark'

a = 'abcDef'
b = 'aBcDef'
c = 'xxxxxx'
n = 10000
Benchmark.bmbm do |x|
  x.reposrt('upcase true'){
    n.times do
      a.upcase == b.upcase
    end
  }
  x.reposrt('upcase false'){
    n.times do
      a.upcase == c.upcase
    end
  }
  x.reposrt('match true'){
    n.times do
      a.upcase == b.upcase
    end
  }
  x.reposrt('match false'){
    n.times do
      a.upcase == c.upcase
    end
  }
end
