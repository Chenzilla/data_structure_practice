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
                           move_queue, discovered)
  puts "Current coords: #{current_coords}"
    if current_coords == target_coords
      puts 'Found it'
      puts "This is the move_queue: #{move_queue}"
      return [[current_coords]]
    elsif discovered.include?(current_coords)
      return false
    end
    puts "Before discovered compare: #{discovered}"
    puts "possible moves: #{possible_moves(current_coords)}"
    undiscovered = []
    possible_moves(current_coords).each do |move|
      if discovered.include?(move)
      else 
        undiscovered << move
      end       
    end
    puts "Before undiscovered check: #{undiscovered}"
    if undiscovered.any? 
      first = true
      check_index = 0
      list = 0
      undiscovered.each_with_index do |move, index|
        puts "Undiscovered origin: #{move}, at index #{index}, with options: #{undiscovered}"
        check_list = breadth_first_search(target_coords, move, move_queue<<move, discovered+[move])
        if check_list
          puts "Checklist: #{check_list}, List: #{list}"
          if first 
            puts 'First'
            check_index = index
            list = check_list
            first = false
          elsif check_list.length < list.length
            'Less than'
            check_index = index
            list = check_list
          else
            puts 'Larger'
          end
        end
      end
      return move_queue += undiscovered[check_index]
    else 
      puts 'dead end'
      return false
    end
  end

  def run_bfs(current_coords=@coords, target_coords)
    breadth_first_search(target_coords, current_coords, [current_coords], [])
  end
end

knight = Knight.new([0,0])
print knight.possible_moves
print knight.run_bfs([3, 3], [4, 3])
