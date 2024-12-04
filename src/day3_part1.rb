# frozen_string_literal: true

class Day3Part1
  def initialize(pathname = nil)
    if pathname
      matches = read_inputs pathname
      puts matches.size
      puts evaluate matches
    end
  end

  def evaluate(expressions)
    expressions.each.reduce(0) { |sum, expression| sum + eval(expression) }
  end

  def mul(a, b)
    a * b
  end

  def read_inputs(pathname)
    file = File.open(pathname)
    chars = file.read
    chars.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)/)
  end
end
