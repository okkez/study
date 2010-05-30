require 'benchmark'

a = 'abcDef'
b = 'aBcDef'
c = 'xxxxxx'
n = 10000
Benchmark.bmbm do |x|
  x.report('upcase true'){
    n.times do
      a.upcase == b.upcase
    end
  }
  x.report('upcase false'){
    n.times do
      a.upcase == c.upcase
    end
  }
  x.report('match true'){
    n.times do
      a.upcase == b.upcase
    end
  }
  x.report('match false'){
    n.times do
      a.upcase == c.upcase
    end
  }
end
