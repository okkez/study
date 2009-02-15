
def jacobi(a)
  n = a.size
  x = Array.new(n){ 0 }
  100.times do
    x1 = Array.new(n){ 0 }
    d = 0.0
    n.times do |i|
      v = a[i][n].to_f
      n.times do |j|
        v -= a[i][j] * x[j] unless j == i
      end
      x1[i] = v / a[i][i]
      d += (x1[i] - x[i]).abs
    end
    x = x1
    # p x
    return x if d < 1.0e-8
  end
  return nil
end

a = [
     [2, 3, 2, 1],
     [2, 5, 4, 4],
     [4, 8, 8, 7],
    ]

jacobi(a.dup) # => nil

a = [
     [5, 2, -1, 19],
     [2, -3, 2, -1],
     [1, 1, -2, 8],
    ]

jacobi(a.dup) # => [2.99999999901441, 0.999999999405356, -1.99999999853375]

# 10.times do
# 
# a = [
#      Array.new(4){ rand(10) + 1},
#      Array.new(4){ rand(10) + 1},
#      Array.new(4){ rand(10) + 1},
#     ]
# 
# p a
# 
# jacobi(a.dup)
# 
# end
#  [[2, 3, 2, 8], [8, 3, 10, 6], [7, 7, 3, 2]] => nil
#  [[10, 2, 1, 1], [7, 6, 8, 5], [2, 5, 6, 7]] => nil
#  [[10, 1, 3, 8], [3, 6, 2, 2], [8, 4, 10, 5]] => [0.854271356056891, -0.0376884433421736, -0.168341709948413]
#  [[9, 3, 1, 1], [5, 4, 1, 3], [1, 2, 7, 6]] => [-0.268115943131439, 0.927536229723395, 0.630434781584467]
#  [[5, 1, 6, 10], [10, 8, 9, 8], [1, 10, 3, 5]] => nil
#  [[3, 5, 9, 3], [1, 10, 6, 4], [6, 5, 5, 10]] => nil
#  [[5, 3, 4, 9], [4, 6, 5, 1], [3, 6, 7, 6]] => nil
#  [[6, 2, 5, 9], [8, 1, 3, 10], [10, 6, 1, 1]] => nil
#  [[10, 7, 8, 9], [7, 4, 5, 8], [10, 9, 4, 3]] => nil
#  [[1, 10, 4, 1], [4, 4, 9, 6], [5, 6, 5, 5]] => nil


def gauss_seidel(a)
  n = a.size
  x = Array.new(n){ 0 }
  100.times do
    d = 0.0
    n.times do |i|
      v = a[i][n].to_f
      n.times do |j|
        v -= a[i][j] * x[j] unless j == i
      end
      tmp = x[i]
      x[i] = v / a[i][i]
      d += (x[i] - tmp).abs
    end
    # p x
    return x if d < 1.0e-8
  end
  return nil
end


a = [
     [2, 3, 2, 1],
     [2, 5, 4, 4],
     [4, 8, 8, 7],
    ]

gauss_seidel(a.dup) # => nil

a = [
     [5, 2, -1, 19],
     [2, -3, 2, -1],
     [1, 1, -2, 8],
    ]

gauss_seidel(a.dup) # => [2.99999999901441, 0.999999999405356, -1.99999999853375]