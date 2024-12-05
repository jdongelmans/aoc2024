require_relative 'advent_of_code_2024'

inputs = File.read('inputs/day05.txt')

ordering_rules, updates = inputs.split("\n\n")
ordering_rules = ordering_rules.split("\n").map { |line| line.split('|').map(&:to_i) }
@grouped_rules = ordering_rules.each_with_object(Hash.new { |h, k| h[k] = [] }) { |(k, v), hash| hash[k] << v }
@updates = updates.split("\n").map { |line| line.split(',').map(&:to_i) }

def in_order?(update)
  update.each_cons(2).all? { |prints| valid?(prints) }
end

def valid?(prints)
  @grouped_rules[prints.first].include?(prints.last)
end

AdventOfCode2024.run(5, 1) do
  @updates.sum do |update|
    in_order?(update) ? update[update.size / 2] : 0
  end
end

# ======================================================================

AdventOfCode2024.run(5, 2) do
  invalids = @updates.reject { |update| in_order?(update) }
  reordered = invalids.each do |update|
    until in_order?(update)
      update.each_cons(2) do |prints|
        unless valid?(prints)
          update.delete_at(update.index(prints.last))
          update.insert(update.index(prints.first), prints.last)
        end
      end
    end
  end

  reordered.sum { |update| update[update.size / 2] }
end
