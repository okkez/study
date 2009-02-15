
require 'benchmark'

def mergesort(a, i, j)
  unless j <= i
    k = (i + j) / 2
    mergesort(a, i    , k)
    mergesort(a, k + 1, j)
    i1 = i
    k1 = k + 1
    b = []
    while i1 <= k || k1 <= j
      if k < i1 || k1 <= j && a[k1] < a[i1]
        b << a[k1]
        k1 += 1
      else
        b << a[i1]
        i1 += 1
      end
    end
    b.size.times{|v| a[i + v] = b[v] }
  end
end

def quicksort(a, i, j)
  unless j <= i
    pivot = a[j]
    s = i
    i.step(j - 1) do |k|
      if a[k] <= pivot
        a[s], a[k] = a[k], a[s]
        s += 1
      end
    end
    a[j], a[s] = a[s], a[j]
    quicksort(a, i, s - 1)
    quicksort(a, s + 1, j)
  end
end

def binsort(a)
  t = Array.new(10000, 0)
  a.each_with_index{|v, i|
    t[v] += 1
  }
  r = []
  t.each_with_index{|v, i|
    v.times{ r << i }
  }
  r
end

def radix_sort(a)
  mask = 1
  0.step(15){|i|
    mask << i
    p, q = a.partition{|v| mask & v == 1 }
    a = p + q
  }
  a
end

Benchmark.bmbm{|x|
  # Array.new(10000){ rand(10000) }
  x.report('merge'){ mergesort(Array.new(10000){ rand(10000) }, 0, 9999) }
  x.report('quick'){ quicksort(Array.new(10000){ rand(10000) }, 0, 9999) }
  x.report('builtin'){ Array.new(10000){ rand(10000) }.sort! }
  x.report('bin'){ binsort(Array.new(10000){ rand(10000) }) }
  x.report('radix'){ radix_sort(Array.new(10000){ rand(10000) }) }
}

# >> Rehearsal -------------------------------------------
# >> merge     0.530000   0.030000   0.560000 (  0.650178)
# >> quick     0.580000   0.030000   0.610000 (  0.611988)
# >> builtin   0.010000   0.000000   0.010000 (  0.012793)
# >> bin       0.060000   0.010000   0.070000 (  0.063565)
# >> radix     0.300000   0.010000   0.310000 (  0.409675)
# >> ---------------------------------- total: 1.560000sec
# >> 
# >>               user     system      total        real
# >> merge     0.720000   0.070000   0.790000 (  0.882609)
# >> quick     0.590000   0.090000   0.680000 (  0.684598)
# >> builtin   0.020000   0.000000   0.020000 (  0.016883)
# >> bin       0.070000   0.020000   0.090000 (  0.082950)
# >> radix     0.320000   0.060000   0.380000 (  0.565791)
