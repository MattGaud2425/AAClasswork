array = [1, 5, 76, 84, 54, 28]

def my_min arr
  target = arr.first
  arr.each do |x|
    target = x if x < target
  end
  target

end

p my_min array # time complexity O(n)


list = [5, 3, -7]

def my_subsum arr
  subsum = arr.first
  arr.each_with_index do |x, idx|
    if idx+1 < arr.length
      j = idx+1
      sub = arr[idx] + arr[j]
      subsum = sub if sub > subsum
    end
  end
  subsum

end


p my_subsum(list) # => 8 # This runs in O(n) space complexity is O(n)
