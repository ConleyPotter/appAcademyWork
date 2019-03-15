array = [1,2,3]

p array.map { |num| num * 2 }

my_proc = Proc.new { |num| num * 2 }

p my_proc.call(3) # => 6

my_proc_2 = Proc.new { |a, b| a + b }
p my_proc_2.call(3,2)   # => 5
p my_proc_2.call(10, 1) # => 11            # Can be reused

def add_and_proc(num_1, num_2, prc) 
  sum = num_1 + num_2
  prc.call(sum)
end

doubler = Proc.new { |n| 2 * n }
p add_and_proc(2, 3, doubler)  # => 10

negate = Proc.new {|n| -1 * n } 
p add_and_proc(6, 3, negate) # => -9

def add_and_proc_2(num_1, num_2, &prc) 
  sum = num_1 + num_2
  prc.call(sum)
end

p add_and_proc_2(2, 3) { |n| n * 2 } # => 10 

# &parameter will automatically convert a block into a proc object

def my_map(arr, &prc)
  new_arr = []

  arr.each { |el| new_arr << prc.call(el)}

  new_arr
end

p my_map([1,2,3]) { |num| num * 2 }