##### Inject Lecture #####

arr = [2, 3, 1, 7]

result = arr.inject { |accum, el| accum + el }
p result # => 13

result1 = arr.inject { |accum, el| accum * el } 
p result1 # => 42

result2 = arr.inject(100) { |accum, el| accum + el }
p result2 # => 113

