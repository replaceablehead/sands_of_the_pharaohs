module Pathfinding

  # use breadth first search to find the shortest path to the target
  # bfs works by exploring tiles outward in all directions one step at a time
  # returns the first step to take toward the target or nil if no path exists
  def self.calculate_path_to_target(start_x, start_y, target_x, target_y, map)
    
    # bundle the start coordinates into a single array
    start = [start_x, start_y]

    # bundle the target coordinates into a single array
    target = [target_x, target_y]

    # tiles that have already been checked
    visited = Array.new 
    # tiles that still need to be checked in current round of searching
    queue = Array.new 
    # tiles to be checked in the next round after the current one
    next_queue = Array.new
    
    # a history of tiles searched and where each one was reached from
    # once the target is found this history becomes the trail we follow back to get the path
    came_from = Array.new 
    
    # add the first tile to the queue
    queue << start
    # add the starting tile to queue but set value to nil as no tile came before it.
    came_from << [start, nil]

    # continue search until queue is empty
    while queue.length > 0
      i = 0

      while i < queue.length
        # take the current tile from the queue and seperate the x and y values
        position = queue[i]
        x = position[0]
        y = position[1]

        # check if this tile has already been visited yet
        already_visited = false
        j = 0
        while j < visited.length
          if visited[j] == position
            already_visited = true
          end
          j += 1
        end

        if !already_visited
          visited << position

          # skip this tile if a wall is detected
          if map.detect_collision(x, y)

            # check if we have reached the target
            if position == target
              return trace_path(came_from, start, position)
            end

            # add all four of the neighbouring tiles to the next queue
            neighbours = Array.new
            neighbours << [x + 1, y]
            neighbours << [x - 1, y]
            neighbours << [x, y + 1]
            neighbours << [x, y - 1]

            
            k = 0
            while k < neighbours.length
              next_position = neighbours[k]

              # check if this neighbour is already in came_from
              already_seen = false
              m = 0
              while m < came_from.length
                if came_from[m][0] == next_position
                  already_seen = true
                end
                m += 1
              end

              if !already_seen
                next_queue << next_position
                came_from << [next_position, position]
              end
              k += 1
            end
          end
        end
        i += 1
      end

      # switch queue to next queue for next round
      queue = next_queue
      next_queue = Array.new
    end

    nil
    end

  # trace back the path from target to start and return the first step toward the target
  def self.trace_path(came_from, start, target)
    path = Array.new
    current = target

    while current != start
      path = [current] + path
      i = 0
      while i < came_from.length
        if came_from[i][0] == current
          current = came_from[i][1]
        end
        i += 1
      end
    end

    path[0]
  end

end