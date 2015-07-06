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

  def run_dfs(value)
    puts depth_first_search(value, @tree, 0)
  end

  def depth_first_search(value, tree, counter)
    if tree[0].nil?
    elsif check_match(value, tree[0], counter)
    elsif depth_first_search(value, tree[1], counter+1)
    elsif depth_first_search(value, tree[2], counter+1)
    end
  end

  def run_bfs(value)
    queue = [@tree[0]]
    puts breadth_first_search(queue, value, 0)
  end

  def breadth_first_search(queue, value, counter)
    while queue.any? do
      node = queue[0]
      if check_match(value, node, counter) || check_children(value, node, counter+1)
      end
      queue = add_queue(node, queue[1..-1])
    end
  end

  def check_children(value, node, counter)
    if node.left_child && node.right_child
      if check_match(value, node.left_child, counter) || check_match(value, node.right_child, counter)
      end
    elsif node.left_child
      check_match(value, node.left_child, counter)
    elsif node.right_child
      check_match(value, node.right_child, counter)
    end
  end

  def add_queue(node, queue)
    queue << node.left_child if !queue.include?(node.left_child) && node.left_child
    queue << node.right_child if node.right_child && !queue.include?(node.right_child)
    queue
  end

  def check_match(value, node, counter)
    if node.value == value
      parent = node.parent ? node.parent.value : 'NA'
      if node.left_child && node.right_child
        print "The node containing #{value} is #{counter} relationships from the root, and has parent #{parent}, left child #{node.left_child.value}, and right child #{node.right_child.value}."
        true
      elsif node.left_child
        print "The node containing #{value} is #{counter} relationships from the root, and has parent #{parent}, left child #{node.left_child.value}, and no right child."
      elsif node.right_child
        print "The node containing #{value} is #{counter} relationships from the root, and has parent #{parent}, right child #{node.right_child.value}, and no left child."
     end 
    else
      false
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

  
end


tree = Tree.new([1, 3, 2, 5, 4, 9])
tree.build_tree
puts ''
print tree.print_tree
puts ''
tree.run_dfs(3)
tree.run_bfs(3)