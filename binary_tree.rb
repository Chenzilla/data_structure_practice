class Node
  attr_accessor :value, :left_child, :right_child, :parent

  def initialize(value)
    @value = value
  end

  def parent(node)
    @parent = node
  end

  def left_child(node)
    @left_child = node
  end

  def right_child(node)
    @right_child = node
  end
end

class Tree

  attr_reader :array

  def initialize(array)
    @array = array
  end

  def build_tree
    tree = []
    @array.shuffle!
    @array.each do |value|
      tree = add_leaf(value, tree)
    end
    print tree
  end

  def add_leaf(value, tree)
    print tree
    print tree.empty?
    puts ''
    parent = tree[0]
    if tree.empty?
      print 'empty'
      tree = [value, [], []]
    elsif value < parent
      tree[1] = add_leaf(value, tree[1])
    elsif value > parent
      tree[2] = add_leaf(value, tree[2])
    end
    tree
  end

end

tree = Tree.new([1, 3, 2, 5, 4, 9])
tree.build_tree