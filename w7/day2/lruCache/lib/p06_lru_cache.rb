require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      linkedlist = @map.get(key)
      # linkedlist.first grabs the node
      # resetting value of this node to point to a new node inside of @store
      # the new node inside of @store holds a key (key inside of linkedlist.first.key)
      # the value (prc.call(key))
      # push into @store the node with key,prc.call(key)
      node = linkedlist.first
      
      return @store.get(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    hashed_key = @prc.call(key)
    @store.append(key, hashed_key)
    @map.set(key, @store.last)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    @store.append(node.key, node.value)
  end

  def eject!
    lru = @store.last
    @store.remove(lru.key)
    @map.set(lru.key, nil)
  end
end

# @map = [LinkedList => Node(key, Node(key,prc(key)))]
# k1 Node(key, Node(key,prc(key))) 
  # prev - @head (of the hashMap = @map)
  # next - k2

# t1 Node(key, prc(key)) [contained inside of k1]
  # prev - @head (of the linkedlist = @store)
  # next - t2
                                  
# k2 Node(key1, t2)
  # prev - k1
  # next - nil

# t2 Node(key1, prc.call(key1)) [node contained inside of k2's val]
  # prev - t1
  # next nil

#...

# @map = [LinkedList(k1), Linkedlist(k2), LinkedList(k3)]
#  max length for @map of 3
# but we want to add a new key

# t1 was least recently used, because its previous is head, so we know it was added
# first, the @store follows a first in first out method of deletion (delinking)

#  new key we want to push in, key4

# k4 Node(key4, t4)
  #  prev - k3
  # next - nil

# t4 Node(key4, prc.call(key4))
  # prev - t3
  # next nil

# reassign the values of the k Nodes to be changed t nodes, so for instance
# the node in k1's value would be t2
