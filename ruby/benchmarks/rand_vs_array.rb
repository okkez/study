require 'benchmark'

def create_integer(min, max, minus)
  begin
    n = rand(max+1)
  end until min <= n
  #(n * sign(minus))
end

def generate_r(max, dont_use = [11,13,17,19,23,29,31,37,41,43,47,53,59])
  ra = (1 .. max).to_a - dont_use
  ra[rand(ra.size)]
end

n = 10000

Benchmark.bmbm do |x|
  x.report('create_integer'){ n.times{ create_integer(1, 100, false) }}
  x.report('generate_r'){ n.times{ generate_r(100) }}
end


# >> Rehearsal --------------------------------------------------
# >> create_integer   0.010000   0.000000   0.010000 (  0.012762)
# >> generate_r       0.250000   0.070000   0.320000 (  0.316877)
# >> ----------------------------------------- total: 0.330000sec
# >> 
# >>                      user     system      total        real
# >> create_integer   0.020000   0.000000   0.020000 (  0.012309)
# >> generate_r       0.280000   0.030000   0.310000 (  0.317323)
