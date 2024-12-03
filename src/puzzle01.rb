# frozen_string_literal: true

class Puzzle01
  def initialize(filename)
    left, right = read_inputs filename
    left.sort!
    right.sort!
    puts left.each_with_index.reduce(0) { |sum, (num, index)| sum + (num - right[index]).abs }
  end

  def read_inputs(filename)
    file = File.open("/Users/peter/artisan/aoc2024/inputs/#{filename}")
    inputs = file.readlines.map(&:chomp)
    left = []
    right = []
    inputs.each do |line|
      row = line.split(" ")
      left.push(row[0].to_i)
      right.push(row[1].to_i)
    end
    [left, right]
  end
end