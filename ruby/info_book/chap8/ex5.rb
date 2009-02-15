

class IntStrTable
  Entry = Struct.new(:key, :value)
  
  def initialize
    @arr = []
  end
  
  def put(key, val)
    @arr.each do |e|
      if e.key == key
        e.value = val
        return
      end
    end
    @arr.push(Entry.new(key, val))
  end
  
  def get(key)
    @arr.each do |e|
      return e if e.key == key
    end
    nil
  end
end

require 'benchmark'

Benchmark.bmbm do |x|
  t = IntStrTable.new
  x.report('1000 put'){
    1000.times{ t.put(rand(100000), "") }
  }
  x.report('1000 get'){
    1000.times{ t.get(rand(100000)) }
  }
  t = IntStrTable.new
  x.report('2000 put'){
    2000.times{ t.put(rand(100000), "") }
  }
  x.report('2000 get'){
    2000.times{ t.get(rand(100000)) }
  }
  t = IntStrTable.new
  x.report('3000 put'){
    3000.times{ t.put(rand(100000), "") }
  }
  x.report('3000 get'){
    3000.times{ t.get(rand(100000)) }
  }
end
# >> Rehearsal --------------------------------------------
# >> 1000 put   0.520000   0.090000   0.610000 (  0.621062)
# >> 1000 get   1.210000   0.200000   1.410000 (  1.502631)
# >> 2000 put   5.330000   1.020000   6.350000 (  6.816214)
# >> 2000 get   7.710000   1.510000   9.220000 ( 10.130831)
# >> 3000 put  17.210000   3.340000  20.550000 ( 22.562223)
# >> 3000 get  22.720000   4.420000  27.140000 ( 30.245843)
# >> ---------------------------------- total: 65.280000sec
# >> 
# >>                user     system      total        real
# >> 1000 put   8.340000   1.550000   9.890000 ( 10.613446)
# >> 1000 get   8.870000   1.750000  10.620000 ( 11.391696)
# >> 2000 put  19.970000   4.200000  24.170000 ( 26.392416)
# >> 2000 get  21.580000   4.280000  25.860000 ( 28.581346)
# >> 3000 put  39.000000   7.600000  46.600000 ( 49.876545)
# >> 3000 get  43.390000   8.880000  52.270000 ( 58.037252)
