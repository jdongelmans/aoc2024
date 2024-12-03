require 'benchmark'

class AdventOfCode2024
  def self.run(day, part, &block)
    runtime = Benchmark.realtime do
      @result = block.call
    end

    puts "[#{(runtime * 1000.0).round(3)}ms] Day #{day} part #{part} result: #{@result}"
  end
end
