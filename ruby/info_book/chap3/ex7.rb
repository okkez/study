
a = (1..100).to_a.shuffle

def array_sum(a)
  sum = 0
  a.size.times do |i|
    sum += a[i]
  end
  sum
end

array_sum(a) # => 5050

def array_max(a)
  max = a[0]
  a.size.times do |i|
    max = a[i] if max <= a[i]
  end
  max
end

array_max(a) # => 100

def array_max_index(a)
  index = 0
  max = array_max(a)
  a.size.times do |i|
    return i if max == a[i]
  end
end

array_max_index(a) # => 41

def array_max_index_all(a)
  index = 0
  max = array_max(a)
  result = []
  a.size.times do |i|
    result << i if max == a[i]
  end
  result
end

array_max_index_all(a+a) # => [41, 141]

def array_less_than_average(a)
  average = array_sum(a) / a.size.to_f
  result = []
  a.size.times do |i|
    result << a[i] if average > a[i]
  end
  result
end

array_less_than_average(a) # => [38, 2, 30, 22, 28, 12, 1, 17, 18, 24, 44, 21, 16, 9, 42, 40, 47, 5, 49, 33, 26, 41, 31, 6, 8, 32, 34, 14, 39, 37, 35, 25, 11, 46, 23, 20, 45, 7, 4, 19, 50, 48, 29, 3, 36, 43, 15, 27, 10, 13]
