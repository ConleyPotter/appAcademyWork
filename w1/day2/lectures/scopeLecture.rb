

### Arrays in memory: ###

arr = Array.new(10, '?')
p arr                    # => ["?", "?", "?", "?", "?", "?", "?", "?", "?", "?"]

grid = Array.new(3, [])
p grid                   # => [[],[],[]]

threebythree = Array.new(3, Array.new(3))
p threebythree           # => [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
threebythree[0][0] = "X"
p threebythree           # => [["X", nil, nil], ["X", nil, nil], ["X", nil, nil]]

# the above will create the desired array, but there is a scope problem
# each array in the inner positions are actually referencing the SAME
# array in memory

# The better syntax is: 
grid1 = Array.new(3) { Array.new(3) }
grid1[0][0] = "X"
p grid1                   # => [["X", nil, nil], [nil, nil, nil], [nil, nil, nil]]