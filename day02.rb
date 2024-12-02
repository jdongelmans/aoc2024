inputs = File.readlines('inputs/day02.txt').map { |line| line.split(' ').map(&:to_i) }

def safe?(line)
  diffs = line.each_cons(2).map { |i, j| i - j }
  return false unless diffs.all?(&:positive?) || diffs.all?(&:negative?)

  diffs.map(&:abs).min >= 1 && diffs.map(&:abs).max <= 3
end

result1 = inputs.count { |line| safe?(line) }
puts "Result 1: #{result1}"

# ======================================================================

result2 = inputs.count do |line|
  safe?(line) || 0.upto(line.length - 1).any? do |i|
    dup = line.dup
    dup.delete_at(i)
    safe?(dup)
  end
end

puts "Result 2: #{result2}"
