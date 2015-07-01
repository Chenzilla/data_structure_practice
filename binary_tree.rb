class Node
  attr_accessor :value, :left_child, :right_child, :parent

  def initialize(value)
    @value = value
    @left_child = false
    @right_child = false
    @parent = false
  end

  def set_parent(node)
    @parent = node
  end

  def set_left_child(node)
    @left_child = node
  end

  def set_right_child(node)
    @right_child = node
  end
end

class Tree

  attr_reader :array

  def initialize(array)
    @array = array
    @tree = []
  end

  def build_tree
    @array.shuffle!
    @array.each do |value|
      @tree = add_leaf(value, @tree, @tree[0])
    end
  end

  def add_leaf(value, tree, parent)
    parent = tree[0]
    if parent.nil?
      tree = [Node.new(value), [], []]
    elsif tree.nil?
      node = Node.new(value)
      node.set_parent(parent)
      if node.value < parent.value
        parent.set_left_child(node)
      else
        parent.set_right_child(node)
      end
    elsif value < parent.value
      tree[1] = add_leaf(value, tree[1], parent)
    elsif value > parent.value
      tree[2] = add_leaf(value, tree[2], parent)
    end
    tree
  end

end


tree = Tree.new([1, 3, 2, 5, 4, 9])
tree.build_tree