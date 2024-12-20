# frozen_string_literal: true

class Day1Part1
  def initialize(pathname)
    left, right = read_inputs pathname
    left.sort!
    right.sort!
    puts left.each_with_index.reduce(0) { |sum, (num, index)| sum + (num - right[index]).abs }
  end

  def read_inputs(pathname)
    left = []
    right = []
    file = File.open(pathname)
    inputs = file.readlines.map(&:chomp)
    inputs.each do |line|
      row = line.split(" ")
      left.push(row[0].to_i)
      right.push(row[1].to_i)
    end
    [left, right]
  end
end

class Day1Part2 < Day1Part1
  def initialize(pathname = nil, left = [], right = [])
    if pathname
      left, right = read_inputs pathname
    end
    left.sort!
    right.sort!
    puts similarity_score(left, element_counts(right))
  end

  def element_counts(sorted_array)
    counts = {}
    sorted_array.each do |num|
      count = counts[num] ||= 0
      counts[num] = count + 1
    end
    counts
  end

  def element_count(element, count_hash)
    count_hash[element] ||= 0
  end

  def similarity_score(left, right_element_counts)
    left.each.reduce(0) { |sum, num| sum + (num * element_count(num, right_element_counts)) }
  end
end
