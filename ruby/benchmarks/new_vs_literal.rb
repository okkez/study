
require 'benchmark'

n = 100000

Benchmark.bmbm{|x|
  x.report('Hash.new'){
    n.times do
      a = Hash.new
    end
  }
  x.report('{} literal'){
    n.times do
      a = { }
    end
  }
  x.report('Array.new'){
    n.times do
      a = Array.new
    end
  }
  x.report('[] literal'){
    n.times do
      a = []
    end
  }
  x.report('Regexp.new'){
    n.times do
      a = Regexp.new('')
    end
  }
  x.report('// literal'){
    n.times do
      a = //
    end
  }
}
