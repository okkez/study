require 'benchmark'
require 'date'

date_range = Date.new(2008,1,1)..Date.new(2008,12,31)
date_targets = { :t => Date.new(2008, 6, 1), :f => Date.new(2009, 6, 1) }
string_range = '2008/01/01'..'2008/12/31'
string_targets = { :t => '2008/06/01', :f => '2009/06/01' }

Benchmark.bmbm do |x|
  x.report('date range (true) '){ 100000.times{ date_range.include?(date_targets[:t]) } }
  x.report('date range (false)'){ 100000.times{ date_range.include?(date_targets[:f]) } }
  x.report('string range (true)'){ 100000.times{ string_range.include?(string_targets[:t]) } }
  x.report('string range (false)'){ 100000.times{ string_range.include?(string_targets[:f]) } }
end
# >> Rehearsal --------------------------------------------------------
# >> date range (true)      1.610000   0.140000   1.750000 (  1.884273)
# >> date range (false)     1.570000   0.160000   1.730000 (  1.850651)
# >> string range (true)    0.200000   0.030000   0.230000 (  0.232997)
# >> string range (false)   0.200000   0.010000   0.210000 (  0.222136)
# >> ----------------------------------------------- total: 3.920000sec
# >> 
# >>                            user     system      total        real
# >> date range (true)      1.590000   0.190000   1.780000 (  1.976390)
# >> date range (false)     1.480000   0.210000   1.690000 (  1.841838)
# >> string range (true)    0.220000   0.020000   0.240000 (  0.225072)
# >> string range (false)   0.200000   0.010000   0.210000 (  0.230877)
