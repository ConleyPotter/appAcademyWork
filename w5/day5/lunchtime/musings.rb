#############################
# |1| |2| |3|


node_1.add_child(node_2)        # node_1 should call add_child with a parameter of new_child_node = node_2
            |                   # which should then call the PolyTreeNode#parent=(new_parent_node) method
            |                   # but because we are working on node_1, we can't call self.parent=(), we need
            |                   # to call .parent=(new_parent_node) on the child node passed in add_child, with the
            |                   # new_parent_node passed in as self
        # [inside this method]
        # given: node_1 = self
        new_child_node.parent=(self)

node_2.parent=(node_1)
            |                   # what happens conceptually when we set a new parent for a node?
            |                   # we actually just set that parent equal to a new node, but we also 
            |                   # remove that node from the parent's children array
        # [inside this method]
        # given: 
        # node_2 = self
        self.parent = new_parent_node
        new_parent_node.add_child(self)
                            |
                            |
                            |
                        # [inside this method]
                        # given: node_1 = self
                        self.children << new_child_node
                        

#############################
# |1|
# /
#|2|