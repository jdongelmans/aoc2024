require_relative 'advent_of_code_2024'

inputs = File.readlines('inputs/day07.txt')

POSSIBLE_OPERATORS = %i[+ *].freeze

AdventOfCode2024.run(7, 1) do
  input = inputs.map do |line|
    result, numbers = line.split(':')
    [result.to_i, numbers.split.map(&:to_i)]
  end

  input.map do |result, numbers|
    result if POSSIBLE_OPERATORS.repeated_permutation(numbers.size - 1).any? do |operators|
      total = numbers[0]
      (numbers.size - 1).times do |i|
        total = total.send(operators[i], numbers[i+1])
      end

      total == result
    end
  end.compact.sum
end

# ======================================================================

AdventOfCode2024.run(7, 2) do

end
