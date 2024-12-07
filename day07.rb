require_relative 'advent_of_code_2024'

inputs = File.readlines('inputs/day07.txt')
input = inputs.map do |line|
  result, numbers = line.split(':')
  [result.to_i, numbers.split.map(&:to_i)]
end

POSSIBLE_OPERATORS_PART1 = %i[+ *].freeze

AdventOfCode2024.run(7, 1) do
  input.map do |result, numbers|
    result if POSSIBLE_OPERATORS_PART1.repeated_permutation(numbers.size - 1).any? do |operators|
      total = numbers[0]
      (numbers.size - 1).times do |i|
        total = total.send(operators[i], numbers[i + 1])
      end

      total == result
    end
  end.compact.sum
end

# ======================================================================

POSSIBLE_OPERATORS_PART2 = %w[+ * ||].freeze

AdventOfCode2024.run(7, 2) do
  input.map do |result, numbers|
    result if POSSIBLE_OPERATORS_PART2.repeated_permutation(numbers.size - 1).any? do |operators|
      total = numbers[0]
      (numbers.size - 1).times do |i|
        total = if operators[i] == '||'
                  [total, numbers[i + 1]].join.to_i
                else
                  total.send(operators[i].to_sym, numbers[i + 1])
                end
      end

      total == result
    end
  end.compact.sum
end
