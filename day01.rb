require_relative 'advent_of_code_2024'

inputs = File.readlines('inputs/day01.txt').map { |line| line.split('   ').map(&:to_i) }
transposed_inputs = inputs.transpose.each(&:sort!)

AdventOfCode2024.run(1, 1) do
  transposed_inputs[0].zip(transposed_inputs[1]).sum { |i, j| (i - j).abs }
end

# ======================================================================

AdventOfCode2024.run(1, 2) do
  inputs.sum { |i, _| i * transposed_inputs[1].count(i) }
end
