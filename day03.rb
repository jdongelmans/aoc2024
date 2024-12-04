require_relative 'advent_of_code_2024'

input = File.read('inputs/day03.txt')

AdventOfCode2024.run(3, 1) do
  input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).sum { |match| match.map(&:to_i).reduce(:*) }
end

# ======================================================================

AdventOfCode2024.run(3, 2) do
  skip = false

  input.scan(/mul\(\d{1,3},\d{1,3}\)|don't\(\)|do\(\)/).map do |match|
    skip = true if match == "don't()"
    skip = false if match == 'do()'

    next if skip

    match.scan(/\d{1,3}/).map(&:to_i).reduce(:*)
  end.compact.sum
end
