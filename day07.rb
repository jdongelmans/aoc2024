require_relative 'advent_of_code_2024'

inputs = File.readlines('inputs/day07.txt')

example = <<~INPUT
  190: 10 19
  3267: 81 40 27
  83: 17 5
  156: 15 6
  7290: 6 8 6 15
  161011: 16 10 13
  192: 17 8 14
  21037: 9 7 18 13
  292: 11 6 16 20
INPUT

POSSIBLE_OPERATORS = %i[+ *].freeze

AdventOfCode2024.run(7, 1) do
  input = inputs.map do |line|
    result, numbers = line.split(':')
    [result.to_i, numbers.split.map(&:to_i)]
  end

  input.map do |result, numbers|
    result if POSSIBLE_OPERATORS.repeated_permutation(numbers.size - 1).any? do |operators|
      equation = numbers.zip(operators).flatten.compact
      total = equation[0]
      (1...equation.length).step(2).each do |i|
        total = total.send(equation[i], equation[i + 1])
      end

      total == result
    end
  end.compact.sum
end

# ======================================================================

AdventOfCode2024.run(7, 2) do

end
