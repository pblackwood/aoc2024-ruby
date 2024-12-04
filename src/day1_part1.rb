# frozen_string_literal: true

class Day1Part1
  def initialize(pathname)
    left, right = read_inputs pathname
    left.sort!
    right.sort!
    puts left.each_with_index.reduce(0) { |sum, (num, index)| sum + (num - right[index]).abs }
  end

  def read_inputs(pathname)
    file = File.open(pathname)
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
