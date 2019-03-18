# Let's explore our classic Depth-First, but for graphs this time! We'll be 
# utilizing the GraphNode and Adjacency List implementations of the following graph:
# (found in picture in this directory)

# Since we already discussed the differences between Depth-First and 
# Breadth-First, we'll focus just on Depth-First here. We'll leave the 
# Breadth-First exploration in the upcoming project.

### Graph Traversal w/ GraphNode ###

# Let's begin by assuming we have our candidate graph implemented using our
# GraphNode class:

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

# One thing we'll have to decide on is what node to begin our traversal. 
# Depending on the structure of the graph, there may not be a suitable starting 
# point. Remember that a graph may not have a "root". However in our candidate, 
# F is like a root. It is the only valid choice because it is the only node 
# that may access all other nodes through some path of edges. We admit, 
# the choice of F is somewhat contrived and in a practical setting you may 
# not have a nice starting point like this. We'll cover how to overcome this 
# obstacle soon. For now we'll take F.


# We want to build a recursive depth_first function that accepts a node and 
# performs a Depth-First traversal through the graph. Let's begin with a 
# baseline solution, although it is not yet complete to handle all graphs:

# broken
def depth_first(node)
  puts node.val

  node.neighbors.each do |neighbor|
    depth_first(neighbor)
  end
end

depth_first(f)

# Can you see where this code goes wrong? It will get caught in an infinite 
# cycle f, e, a, e, a, e, a, e, ... ! To fix this, simply store which nodes we 
# have visited already. Whenever we hit a node that has previously been visited, 
# then return early. We'll use Ruby Sets to store visited because they allow for 
# constant time lookup.

# using GraphNode representation

def depth_first(node, visited = Set.new())
  # if this node has already been visited, then return early
  return nil if (visited.include?(node.val))

  # otherwise it hasn't yet been visited,
  # so print its val and mark it as visited.
  puts node.val
  visited.add(node.val)

  # then explore each of its neighbors
  node.neighbors.each do |neighbor|
    depth_first(neighbor, visited);
  end
end

depth_first(f)

# This code works well and will print the values in the order f, e, a, c, b, d. 
# Note that this strategy only works if the values are guaranteed to be unique.

### Graph Traversal w/ Adjacency List ###

# Let's now assume our candidate graph in the form of an Adjacency List:

graph = {
  'a': ['b', 'c', 'e'],
  'b': [],
  'c': ['b', 'd'],
  'd': [],
  'e': ['a'],
  'f': ['e']
}

# Bear in mind that the nodes are just strings now, not GraphNodes. Other than 
# that, the code shares many details from our previous implementations:

# using Adjacency List representation

def depth_first(node, graph, visited = Set.new())
  return nil if visited.include?(node.to_sym)

  puts node
  visited.add(node.to_sym)

  graph[node.to_sym].each do |neighbor|
    depth_first(neighbor, graph, visited);
  end
end

depth_first('f', graph)

# Cool! We print values in the order f, e, a, b, c, d.

# Instead, let's draw our attention to a point from before: having to choose f 
# as the starting point isn't dynamic enough to be impressive. Also, if we 
# choose a poor initial node, some nodes may be unreachable. For example, 
# choosing a as the starting point with a call to depth_first('a', graph) will 
# only print a, b, c, d, e. We missed out on f. Bummer.

# We can fix this. A big advantage of using an Adjacency List is that it 
# contains the full graph! We can use a surrounding loop to allow our traversal 
# to jump between disconnected regions of the graph. Refactoring our code:

def depth_first(graph)
  visited = Set.new()
  graph.keys.each do |node|
    _depth_first(node, graph, visited)
  end
end

def _depth_first(node, graph, visited)
  return nil if visited.include?(node.to_sym)

  puts node
  visited.add(node.to_sym)

  graph[node.to_sym].each do |neighbor|
    _depth_first(neighbor, graph, visited)
  end
end

depth_first(graph)

# Notice that our main function depth_first is iterative and accepts the entire 
# Adjacency List as an arg. Our helper _depth_first is recursive. _depth_first 
# serves the same job as before, it will explore a full connected region in a 
# graph. The main depth_first method will allow us to "bridge" the gap between 
# connection regions.

# Still fuzzy? Imagine we had the following graph. Before you ask, these are not 
# two separate graphs. This is a single graph that contains two connected 
# components. Another term for a graph of this structure is a "Forest" because 
# it contains multiple "Trees", ha:

# picture in dir

# It is easy to represent this graph using an Adjacency List. We can then pass 
# the graph into our depth_first from above:

graph = {
  'h': ['i', 'j'],
  'i': [],
  'j': ['k'],
  'k': [],
  'l': ['m'],
  'm': []
}

depth_first(graph)
# prints h, i, j, k, l, m

# Here's the description for how depth_first operates above. We enter depth_first 
# and the each loop begins on h. This means we enter our _depth_first, which 
# will continue to explore the "local" region as far as possible. When this 
# recursion ends, we would have explored the entire connected region of 
# h, i, j, k (note that we add these nodes to visited as well). Our recursive 
# call then returns to the main depth_first function, where we continue the 
# each loop. We iterate it until we hit an unvisited node (l) and then explore 
# it's local region as far as possible using _depth_first, hitting the last 
# node m.