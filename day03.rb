inputs = File.read('inputs/day03.txt')

result1 = inputs.scan(/mul\(\d{1,3},\d{1,3}\)/).sum do |match|
  match.scan(/\d+/).map(&:to_i).reduce(:*)
end

puts "Result 1: #{result1}"

# ======================================================================

skip = false
result2 = inputs.scan(/mul\(\d{1,3},\d{1,3}\)|don't\(\)|do\(\)/).map do |match|
  skip = true if match == "don't()"
  skip = false if match == 'do()'

  next if skip

  match.scan(/\d+/).map(&:to_i).reduce(:*)
end.compact.sum

puts "Result 2: #{result2}"
