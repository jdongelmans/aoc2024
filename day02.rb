require_relative 'advent_of_code_2024'

inputs = File.readlines('inputs/day02.txt').map { |line| line.split(' ').map(&:to_i) }

def safe?(line)
  diffs = line.each_cons(2).map { |i, j| i - j }
  return false unless diffs.all?(&:positive?) || diffs.all?(&:negative?)

  diffs.map(&:abs).min >= 1 && diffs.map(&:abs).max <= 3
end

AdventOfCode2024.run(2, 1) do
  inputs.count { |line| safe?(line) }
end

# ======================================================================

AdventOfCode2024.run(2, 2) do
  inputs.count do |line|
    safe?(line) || 0.upto(line.length - 1).any? do |i|
      dup = line.dup
      dup.delete_at(i)
      safe?(dup)
    end
  end
end
