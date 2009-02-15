require 'pp'

def gauss(a)
  n = a.size
  n.times do |i|
    (i + 1).upto(n - 1) do |j|
      r = a[j][i] / a[i][i].to_f
      i.step(n) do |k|
        a[j][k] = a[j][k] - a[i][k] * r
      end
    end
  end
  (n - 1).downto(0) do |i|
    a[i][n] = a[i][n] / a[i][i]
    a[i][i] = 1.0
    i.times do |j|
      a[j][n] = a[j][n] - a[j][i] * a[i][n]
    end
  end
  a
end

gauss([[2, 3, 2, 1],
         [2, 5, 4, 4],
         [4, 8, 8, 7]]) # => [[1.0, 3  , 2  , -1.25],
                        #     [0.0, 1.0, 2.0,  0.5],
                        #     [0.0, 0.0, 1.0,  1.0]]

gauss([[2, 3, 2, 1],
         [2, 3, 4, 4],
         [4, 8, 8, 7]]) # => [[1.0,   3,   2, NaN],
                        #     [0.0, 1.0, 2.0, NaN],
                        #     [0.0, NaN, 1.0, NaN]]
# ex1-a
def gauss_jordan(a)
  n = a.size
  n.times do |i|
    n.times do |j|
      unless i == j
        r = a[j][i] / a[i][i].to_f
        i.upto(n) do |k|
          a[j][k] = a[j][k] - a[i][k] * r
        end
      end
    end
  end
  n.times do |i|
    a[i][n] = a[i][n] / a[i][i]
  end
  a
end

gauss_jordan([[2, 3, 2, 1],
                 [2, 5, 4, 4],
                 [4, 8, 8, 7]])

gauss_jordan([[2, 3, 2, 1],
                 [2, 3, 4, 4],
                 [4, 8, 8, 7]])



def gauss_jordan2(a)
  n = a.size
  index = Array.new(n){|i| i }
  n.times do |i|
    pivot = a.index{|w| w[i].abs == a.transpose[i].max_by(&:abs) }
    return nil if pivot.nil? or a[pivot][i].abs < 0.000001
    unless pivot == 0
      a[i], a[pivot] = a[pivot], a[i]
      index[i], index[pivot] = index[pivot], index[i]
    end
    n.times do |j|
      unless i == j
        r = a[j][i] / a[i][i].to_f
        i.upto(n) do |k|
          a[j][k] = a[j][k] - a[i][k] * r
        end
      end
    end
  end
  result = []
  n.times do |i|
    k = index[i]
    result[k] = a[k][n] / a[k][k]
  end
  result
end

# pp gauss_jordan2([[2, 3, 2, 1],
#                   [2, 5, 4, 4],
#                   [4, 8, 8, 7]])
# 
# pp gauss_jordan2([[2, 3, 2, 1],
#                   [2, 3, 4, 4],
#                   [4, 8, 8, 7]])
# 
pp gauss_jordan2([[2, 3, 2, 1],
                  [2, 3, 4, 4],
                  [1, 1, 1, 7]])
