require_relative 'advent_of_code_2024'

matrix = File.readlines('inputs/day04.txt').map(&:chars)

XMAS_OFFSETS = [
  [[1, 0], [2, 0], [3, 0]],
  [[-1, 0], [-2, 0], [-3, 0]],
  [[0, 1], [0, 2], [0, 3]],
  [[0, -1], [0, -2], [0, -3]],
  [[1, 1], [2, 2], [3, 3]],
  [[-1, -1], [-2, -2], [-3, -3]],
  [[1, -1], [2, -2], [3, -3]],
  [[-1, 1], [-2, 2], [-3, 3]]
].freeze
FOLLOW_UP_LETTERS = %w[M A S].freeze

AdventOfCode2024.run(4, 1) do
  matrix.each_with_index.sum do |row, idx_r|
    row.each_with_index.sum do |char, idx_c|
      next 0 unless char == 'X'

      XMAS_OFFSETS.count do |offset|
        offset.each_with_index.all? do |(row_offset, col_offset), idx_o|
          search_row = idx_r + row_offset
          search_col = idx_c + col_offset

          next if search_row.negative? || search_row >= matrix.length ||
                  search_col.negative? || search_col >= matrix[0].length

          matrix[search_row][search_col] == FOLLOW_UP_LETTERS[idx_o]
        end
      end
    end
  end
end

# ======================================================================

X_MAS_OFFSETS = [
  [[-1, -1], [1, 1]],
  [[1, 1], [-1, -1]],
  [[-1, 1], [1, -1]],
  [[1, -1], [-1, 1]]
].freeze

AdventOfCode2024.run(4, 2) do
  matrix.each_with_index.sum do |row, idx_r|
    row.each_with_index.count do |char, idx_c|
      next unless char == 'A'

      X_MAS_OFFSETS.all? do |offset|
        offset.each_with_object(%w[M S]) do |(row_offset, col_offset), required_letters|
          search_row = idx_r + row_offset
          search_col = idx_c + col_offset

          next if search_row.negative? || search_row >= matrix.length ||
                  search_col.negative? || search_col >= matrix[0].length

          required_letters.delete(matrix[search_row][search_col])
        end.empty?
      end
    end
  end
end
