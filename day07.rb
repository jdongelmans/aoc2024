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

def recursive_result_possible?(result, numbers, index = 0, total = numbers[0], include_concatenation: false)
  return total == result if index == numbers.size - 1

  next_index = index + 1
  next_number = numbers[next_index]

  if (total + next_number) <= result
    return true if recursive_result_possible?(result, numbers, next_index, total + next_number, include_concatenation: include_concatenation)
  end

  if (total * next_number) <= result
    return true if recursive_result_possible?(result, numbers, next_index, total * next_number, include_concatenation: include_concatenation)
  end

  if include_concatenation
    new_total = total.concat(next_number)

    if new_total <= result
      return true if recursive_result_possible?(result, numbers, next_index, new_total, include_concatenation: include_concatenation)
    end
  end

  false
end

AdventOfCode2024.run(7, 1) do
  input.sum do |result, numbers|
    # result_possible?(result, numbers) ? result : 0
    recursive_result_possible?(result, numbers) ? result : 0
  end
end

# ======================================================================

AdventOfCode2024.run(7, 2) do
  input.sum do |result, numbers|
    # result_possible?(result, numbers, include_concatenation: true) ? result : 0
    recursive_result_possible?(result, numbers, include_concatenation: true) ? result : 0
  end
end
