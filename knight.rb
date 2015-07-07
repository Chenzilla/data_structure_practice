include Math

class Knight
  attr_reader :coords

  def initialize(coords)
    puts 'Knight initialized'
    if check_coord(coords)
      @coords = coords
    else 
      puts 'Invalid coordinates; try again.'
    end
  end

  def check_coord(coords)
    if coords[0] < 0 || coords[0] > 8 || coords[1] < 0 || coords[1] > 8
      false
    else 
      true
    end
  end

  # def distance_to(current_coords, target_coords)
  #   Math.sqrt((@coords[0] - target_coords[0])**2 + (@coords[1] - target_coords[1])**2)
  # end

  def possible_moves(coords = @coords)
    moves_list = []
    moves = [[coords[0]+2, coords[1]+1], [coords[0]+1, coords[1]+2], [coords[0]+2, coords[1]-1], [coords[0]+1, coords[1]-2], 
            [coords[0]-2, coords[1]+1], [coords[0]-1, coords[1]+2], [coords[0]-2, coords[1]-1], [coords[0]-1, coords[1]-2]]
    moves.each do |coordinate|
      moves_list << coordinate if check_coord(coordinate)
    end
    moves_list
  end

  # def next_best_move(array, target_coords)
  #   print "Array: #{array}"
  #   first = true
  #   current_distance = 0
  #   current_index = 0
  #   array.each_with_index do |move, index|
  #     distance_to = distance_to(move, target_coords)
  #     puts "Check distance: #{distance_to}"
  #     if first
  #       current_distance = distance_to
  #       current_index = index
  #     elsif distance_to <= current_distance 
  #       current_distance = distance_to
  #       current_index = index
  #     end
  #   end
  #   puts "Best: #{array[current_index]}"
  #   array[current_index]
  # end

  def breadth_first_search(target_coords, current_coords, 
                           move_queue, queue, discovered)
    while queue.any? do

      return move_queue << next_move if current_coords == target_coords
      
      undiscovered = []
      possible_moves(current_coords).each do |move|
        if discovered.exist?(move)
          undiscovered << move 
        else 
          discovered << move
        end       
      end
 
      undiscovered.each_with_index do |move, index|
        check = breadth_first_search(target_coords, move, move_queue<<move, queue<<move)
        if check.length < check_index
      end
    end
    move_queue
  end

  def run_bfs(target_coords, current_coords=@coords)
    breadth_first_search(target_coords, current_coords, [current_coords])
  end
end

knight = Knight.new([0,0])
print knight.possible_moves
print knight.run_bfs([3, 3], [4, 3])
