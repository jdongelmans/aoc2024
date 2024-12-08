require_relative 'advent_of_code_2024'

input = File.readlines('inputs/day07.txt').map do |line|
  result, numbers = line.split(':')
  [result.to_i, numbers.split.map(&:to_i)]
end

class Integer
  def concat(other_value)
    multiplier = 10**other_value.to_s.size
    self * multiplier + other_value
  end
end

def result_possible?(result, numbers, include_concatenation: false)
  possible_operators = %i[+ *]
  possible_operators << :concat if include_concatenation

  possible_operators.repeated_permutation(numbers.size - 1).any? do |operators|
    total = numbers[0]

    (numbers.size - 1).times { |i| total = total.send(operators[i], numbers[i + 1]) }

    total == result
  end
end

AdventOfCode2024.run(7, 1) do
  input.sum do |result, numbers|
    result_possible?(result, numbers) ? result : 0
  end
end

# ======================================================================

AdventOfCode2024.run(7, 2) do
  input.sum do |result, numbers|
    result_possible?(result, numbers, include_concatenation: true) ? result : 0
  end
end
