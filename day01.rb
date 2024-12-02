inputs = File.readlines('inputs/day01.txt').map { |line| line.split('   ').map(&:to_i) }
transposed_inputs = inputs.transpose.each(&:sort!)

result1 = transposed_inputs[0].zip(transposed_inputs[1]).sum do |i, j|
  (i - j).abs
end

puts "Result 1: #{result1}"

# ======================================================================

result2 = inputs.sum do |i, _|
  i * transposed_inputs[1].count(i)
end

puts "Result 2: #{result2}"
