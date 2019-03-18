### Graphs ###

# It's time to generalize our knowledge! We've explored binary trees and the
# fundamental alogrithms that accompany them. Natrualy, we implemented these 
# algorithms assuming the constrains of a binary tree. To review, these 
# assumptions include the clack of cycles, a maximum of two children, and
# a single root note. However, what if we take away these constraints? 
# How can we modify the algorithms to operate on general maps? 

### What is a Graph? ###

# A graph is any collection of nodes and edges. In contrast to our previous trees,
# a graph is much more relaxed in it's structure. A graph may:
    # - lack a root node
    # - have cycles
    # - have any number of edges leaving a node
# In this section, we will draw heavily from our tree algorithms. The adjustments
# we will maek to those algos will be motivated by these core differences.

# Below are a few examples of agraphs that don't agree with our CompSci definition
# of a binary tree: (file in the same folder has picture)

# Here are some highlights:
    # - Graph 1 lacks a root. This means there is no single node that can access
    #   all other nodes in a path through edges. This is important bc we previously
    #   referenced "entire" trees by referring to the ultimate root. We can no
    #   longer do that in a graph. If we provide just T, you can't access U.
    #   If we provide you just U, you can't access T. If we provide just V,
    #   you can't access T or U.
    # - Graph 2 has a cycle. This means there is no longer a parent-child 
    #   parent-child relationship. Choose any node in Graph 2, its grandchild will
    #   also be its parent. Wait - what? From now on we'll ahve to use less
    #   specific langauge such as "X is a neighbor of Y." Perhaps more deadly,
    #   imagine we ran a "simple" depth-first traversal on this graph. We could
    #   get trapped in an infinite loop if we are not careful. 
    # - Graph 3 features nodes that have more than 2 edges. Anarchy!

### Graph Implementations ###

# There ar emany wayas to represent a graph programmatically. Let's take a
# moment to explore each and describe the tradeoffs we make when choosing among
# them. We will use Graph 3 from above as our candidate. Bear in mind that our
# graph is directed. For example, this means that C can access D, but D cannot
# access C.

### GraphNode Class ###

# This implementation is most similar to how we implemented binary trees. That 
# is, we create a node class that maintains a value and an array of references 
# to neighboring nodes. This easily solves the problem that a node can have any 
# number of neighbors, no longer just a left and right.

class GraphNode
  attr_accessor :val, :neighbors

  def initialize(val)
    self.val = val
    self.neighbors = []
  end
end

a = GraphNode.new('a')
b = GraphNode.new('b')
c = GraphNode.new('c')
d = GraphNode.new('d')
e = GraphNode.new('e')
f = GraphNode.new('f')
a.neighbors = [b, c, e]
c.neighbors = [b, d]
e.neighbors = [a]
f.neighbors = [e]

# This implementation is great because it feels familiar to how we implemented 
# trees. However, this implementation is clunky in that we have no easy way to 
# refer to the entire graph. How can we pass this graph to a function? Recall 
# that there is no root to act as the definite starting point.

### Adjacency Matrix ###

# This is the often the mathematician's preferred way of representing a graph. 
# We use a 2D array to represent edges. We'll first map each node's value to 
# an index. This means A -> 0, B -> 1, C -> 2, etc.. Below is the mapping for Graph 3:

# found in file in this dir

# From here, the row index will correspond to the source of an edge and the 
# column index will correspond to its destination. A value of true will mean 
# that there does exist an edge from source to destination.

matrix = [
#   A       B       C       D       E       F
  [true,  true,   true,   false,  true,   false], # A
  [false, true,   false,  false,  false,  false], # B
  [false, true,   true,   true,   false,  false], # C
  [false, false,  false,  true,   false,  false], # D
  [true,  false,  false,  false,  true,   false], # E
  [false, false,  false,  false,  true,   true]   # F
]

# A few things to note about using an adjacency matrix:
    # - when the edges have direciton, matrix[i][j] may not be the same as
    #   matrix[j][i]
    # - it is common to say that a node is adjacent to itself, so matrix[x][x] == true
    #   for any x

# An advantage of the matrix implementation is that it allows us to refer to 
# the entire graph by simply referring to the 2D array. A huge disadvantage of 
# using a matrix is the space required. To represent a graph of n nodes, we must 
# allocate n**2 space for the 2D array. This is even more upsetting when there 
# are few edges in graph. We will have to use n**2 space, even though the array 
# would be sparse with only a few true elements.

### Adjacency Lists ###

# An adjacency list seeks to solve the shortcomings of the matrix implementation. 
# We use a hash where keys represent the node labels. The values associated with 
# the keys will be an array containing all adjacent nodes:

graph = {
  'a': ['b', 'c', 'e'],
  'b': [],
  'c': ['b', 'd'],
  'd': [],
  'e': ['a'],
  'f': ['e']
}

# An adjacency list is easy to implement and allows us to refer to the entire 
# graph by simply referencing the object. The space required for an adjacency list
# is the number of edges in the graph. Since there will be at most n**2 edges 
# in a graph of n nodes, the adjacency list will use at most the same amount of 
# space as the matrix. You'll find adjacency lists useful when attacking problems 
# that are not explicitly about graphs. We'll elaborate more on this soon.