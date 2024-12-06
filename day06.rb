require_relative 'advent_of_code_2024'

input = File.readlines('inputs/day06.txt')
starting_matrix = input.map(&:chars)

def find_starting_position(matrix)
  matrix.each_with_index do |row, y|
    row.each_with_index do |char, x|
      return [x, y] if char == '^'
    end
  end
end

DIRECTIONS = [
  [0, -1], # up
  [1, 0], # right
  [0, 1], # down
  [-1, 0] # left
].freeze

def walk_matrix(starting_matrix)
  matrix = Marshal.load(Marshal.dump(starting_matrix))
  current_position = find_starting_position(matrix)
  direction_idx = 0

  visited_positions = []

  loop do
    dx, dy = DIRECTIONS[direction_idx]
    next_position = [current_position[0] + dx, current_position[1] + dy]

    if next_position[0].negative? || next_position[1].negative? ||
       next_position[0] >= matrix[0].size || next_position[1] >= matrix.size
      visited_positions << current_position

      break visited_positions.uniq
    end

    if matrix[next_position[1]][next_position[0]] == '#'
      direction_idx = (direction_idx + 1) % DIRECTIONS.size
    else
      visited_positions << current_position
      current_position = next_position
    end

  end
end

AdventOfCode2024.run(6, 1) do
  visited_positions = walk_matrix(starting_matrix)
  visited_positions.count
end

# ======================================================================

AdventOfCode2024.run(6, 2) do
  visited_positions = walk_matrix(starting_matrix)
  starting_position = find_starting_position(starting_matrix)
  possible_obstructions = 0

  visited_positions.each do |x, y|
    matrix = Marshal.load(Marshal.dump(starting_matrix))
    current_position = starting_position

    next if current_position == [x, y]

    direction_idx = 0
    matrix[y][x] = '#'
    visited_states = []

    loop do
      current_state = "#{current_position[1]},#{current_position[0]}:#{direction_idx}"

      dx, dy = DIRECTIONS[direction_idx]
      next_position = [current_position[0] + dx, current_position[1] + dy]

      if next_position[0].negative? || next_position[1].negative? ||
         next_position[0] >= matrix[0].size || next_position[1] >= matrix.size

        break
      end

      if matrix[next_position[1]][next_position[0]] == '#'
        direction_idx = (direction_idx + 1) % DIRECTIONS.size
      else
        if visited_states.include?(current_state)
          possible_obstructions += 1

          break
        end

        visited_states << current_state
        current_position = next_position
      end
    end
  end

  possible_obstructions
end
