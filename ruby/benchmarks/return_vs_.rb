require 'benchmark'

def a
  return :a
end

def b
  :b
end

def c(arg)
  return arg
end

def d(arg)
  arg
end

n = 10**6
Benchmark.bmbm do |x|
  x.report('return'){ n.times{ a() } }
  x.report('no return'){ n.times{ b() } }
  x.report('return'){ n.times{ c(:c) } }
  x.report('no return'){ n.times{ d(:d) } }
end
# >> Rehearsal ---------------------------------------------
# >> return      0.480000   0.250000   0.730000 (  0.726103)
# >> no return   0.330000   0.170000   0.500000 (  0.506351)
# >> return      0.540000   0.220000   0.760000 (  0.770239)
# >> no return   0.400000   0.150000   0.550000 (  0.545196)
# >> ------------------------------------ total: 2.540000sec
# >> 
# >>                 user     system      total        real
# >> return      0.530000   0.190000   0.720000 (  0.720445)
# >> no return   0.330000   0.180000   0.510000 (  0.501015)
# >> return      0.590000   0.160000   0.750000 (  0.755077)
# >> no return   0.380000   0.160000   0.540000 (  0.538025)
