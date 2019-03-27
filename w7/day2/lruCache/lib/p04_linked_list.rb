

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = first
     return if empty?
     while node != @tail && node.key != key 
       node = node.next
     end
     node.val
  end

  def include?(key)
    node = first
    while node.key != key && node != @tail
      node = node.next
    end
    return true if node.key
    false
  end

  def append(key, val)
    new_node = Node.new(key,val)
    current_end = @tail.prev
    current_end.next = new_node
    @tail.prev = new_node
    new_node.next = @tail
    new_node.prev = current_end
  end

  def update(key, val)
     node = first
     return if empty?
     while node.key != key && node != @tail
       node = node.next
     end
     node.val = val
  end

  def remove(key)
    node = first
    while node.key != key
      node = node.next
    end
    temp_node = node.next
    temp_node.prev = node.prev
    node.prev.next = temp_node
    node
  end

  def each(&prc)
     node = first
     while node != @tail
       prc.call(node)
       node = node.next
     end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
