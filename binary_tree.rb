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

  attr_reader :array, :tree

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
    if parent.nil?
      tree = [Node.new(value), [], []]
    elsif tree[0].nil?
      node = Node.new(value)
      node.set_parent(parent)
      if node.value < parent.value
        parent.set_left_child(node)
      else
        parent.set_right_child(node)
      end
      tree = [node, [], []]
    elsif value < tree[0].value
      puts "Value #{value} is smaller than #{tree[0].value}"
      tree[1] = add_leaf(value, tree[1], tree[0])
    elsif value > tree[0].value
      puts "Value #{value} is larger than #{tree[0].value}"
      tree[2] = add_leaf(value, tree[2], tree[0])
    end
    tree
  end

  def print_tree
    print value_tree(@tree)
  end

  def value_tree(tree)
    if tree[0].nil?
      []
    elsif tree[1].nil? && tree[2].nil?
      [tree[0].value, [], []]
    elsif !(tree[1].nil? && tree[2].nil?)
      [tree[0].value, value_tree(tree[1]), value_tree(tree[2])]
    elsif tree[1][0].nil? 
      [tree[0].value, [], value_tree(tree[2])]
    else
      [tree[0].value, value_tree(tree[1]), []]
    end
  end
  # def depth_first_search(value, tree = @tree, queue = [], counter = 0)
  #   queue = [tree[0]]
  #   found = false
  #   until queue.empty? || found do
  #     current = queue[0]
  #     result = current.value
  #     found = check_match(current, value, counter)
  #     else
  #       if current.left_child && current.right_child
  #         if check_match(current.left_child, value, counter+1)
  #         else queue += current.left_child
  #         end
  #         if check_match(current.right_child, value, counter+1)
  #         end
  #       end
  #     end
  #   end
  # end

  def check_match(node, value, counter)
    if node.value == value
      print "The node containing #{value} is #{counter} relationships from the root, and has parent: #{node.parent}, left child: #{node.left_child}, and right child: #{node.right_child}."
      true
    else
      false
    end
  end
end


tree = Tree.new([1, 3, 2, 5, 4, 9])
tree.build_tree
puts ''
print tree.print_tree
