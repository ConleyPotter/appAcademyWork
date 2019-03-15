require 'byebug'

module Searchable
  def dfs(target_value)
    # debugger
    # return nil if self.nil?
    return self if self.value == target_value
    self.children.each do |child|
      # next if child.nil?
      searched_node = child.dfs(target_value)
      return searched_node unless searched_node.nil?
    end
    nil
  end

  def bfs(target_value)
    que = []
    que << self
    until que.empty?
      shifted_node = que.shift
      if shifted_node.value == target_value
        return shifted_node
      else
        shifted_node.children.each { |child| que << child }
      end
    end
    nil
  end
end

class PolyTreeNode
  include Searchable

  def initialize(value)
    @value = value
    @parent = nil # is a PolyTreeNode
    @children = []
  end
  
  def parent=(new_parent_node)
    if self.parent # remove self from old siblings while we still have the reference to our old parent
      old_siblings = self.parent.children
      old_siblings.delete(self)
    end

    @parent = new_parent_node
    new_parent_node.children << self unless new_parent_node.nil?
  end
  
  def add_child(child_node)
    child_node.parent = self #self becomes the parent        
  end
  
  def remove_child(child_node)
    raise "That node is not in the current node's children" if !@children.include?(child_node)
    child_node.parent = nil
  end
  
  attr_reader :parent, :children, :value

end
