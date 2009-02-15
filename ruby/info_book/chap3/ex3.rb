
def prime?(n)
  return false if n == 1
  return true if n == 2
  (2..Math.sqrt(n).to_i).each do |i|
    return false if n % i == 0
  end
  return true
end

(1..100).each do |n|
  prime?(n) # =>
end
