# require 'byebug'
class PolyTreeNode
  
    def initialize(value)
        @value = value
        @parent = nil # is a PolyTreeNode
        @children = []
    end
  
    def parent=(new_parent_node)
        # debugger
        @parent = new_parent_node
        self.parent.add_child(self)
        nil
    end
    
    def add_child(child_node)
      # debugger
      if child_node.parent.nil?
        child_node.parent = self
      else
        if child_node.parent != self
          child_node.parent = self
        else
          @children << child_node
        end
      end
      nil
    end
    
    def remove_child(child)
      to_delete = @children.index(child)
      @children.delete_at(to_delete)
      nil
    end
    
    attr_reader :parent, :children, :value
end

node_1 = PolyTreeNode.new(1)
node_2 = PolyTreeNode.new(2)
node_3 = PolyTreeNode.new(3)
node_4 = PolyTreeNode.new(4)
node_1.add_child(node_2)
