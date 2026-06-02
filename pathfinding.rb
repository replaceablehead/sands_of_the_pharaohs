module Pathfinding

  # use breadth first search to find the shortest path to the target
  # returns the first step to take toward the target or nil if no path exists
  def self.find_path(start_x, start_y, target_x, target_y, map)
    start = [start_x, start_y]
    target = [target_x, target_y]

    visited = []
    queue = [start]
    next_queue = []
    came_from = []
    came_from << [start, nil]

    while !queue.empty?
      queue.each do |pos|
        x, y = pos

        next if visited.include?(pos)
        visited << pos

        next if !map.detect_collision(x, y)

        return trace_path(came_from, start, pos) if pos == target

        [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].each do |nx, ny|
          next_pos = [nx, ny]
          next_queue << next_pos
          came_from << [next_pos, pos] unless came_from.any? { |p, _| p == next_pos }
        end
      end

      queue, next_queue = next_queue, queue.clear
    end

    nil
  end

  # trace back the path from target to start and return the first step
  def self.trace_path(came_from, start, target)
    path = []
    current = target
    while current != start
      path.unshift(current)
      current = came_from.find { |pos, _| pos == current }[1]
    end
    path.first
  end

end