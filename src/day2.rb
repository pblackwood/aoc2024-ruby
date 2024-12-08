# frozen_string_literal: true

class Day2Part1
  def initialize(pathname = nil, reports = [])
    if pathname
      reports = read_inputs pathname
    end
    safe_count = 0
    reports.each do |report|
      safe_count += 1 if is_safe report
    end
    puts safe_count
  end

  def is_safe(report)
    direction = 1
    report.each_with_index do |level, index|
      return false if direction == 0
      return true if index == report.length - 1
      case index
      when 0
        direction = compare_ints(level, report[index + 1])
        return false if (level - report[index + 1]).abs > 3
      else
        return false if direction != compare_ints(level, report[index + 1])
        return false if (level - report[index + 1]).abs > 3
      end
    end
  end

  def compare_ints(a, b)
    a <=> b
  end

  def read_inputs(pathname)
    reports = []
    file = File.open(pathname)
    lines = file.readlines.map(&:chomp)
    lines.each do |line|
      levels = line.split(" ").map(&:to_i)
      reports.push(levels)
    end
    reports
  end
end

class Day2Part2 < Day2Part1
  def initialize(pathname = nil, reports = [])
    if pathname
      reports = read_inputs pathname
    end
    safe_count = 0
    reports.each do |report|
      safe_count += 1 if is_safe(report) || is_dampened_safe(report)
    end
    puts safe_count
  end

  def is_dampened_safe(report)
    report.length.times do |index_to_remove|
      return true if is_safe(array_with_a_hole(report, index_to_remove))
    end
    false
  end

  def array_with_a_hole(array, index_to_remove)
    a = array.dup
    a.slice! index_to_remove
    a
  end

end
