# frozen_string_literal: true

class Day3Part1
  MUL_MATCHER = /mul\([0-9]{1,3},[0-9]{1,3}\)/

  def initialize(pathname = nil, input = nil)
    if pathname
      matches = read_inputs pathname
      puts matches.size
      puts evaluate_range matches
    end

    # for specs
    if input
      @input = input
    end
  end

  def evaluate_range(expressions)
    expressions.each.reduce(0) { |sum, expression| sum + eval(expression) }
  end

  def mul(a, b)
    a * b
  end

  def read_inputs(pathname)
    file = File.open(pathname)
    chars = file.read
    chars.scan(MUL_MATCHER)
  end
end

class Day3Part2 < Day3Part1
  DO_DONT_MATCHER = /do\(\)|don't\(\)/

  def initialize(pathname = nil, input = nil)
    if pathname
      commands = read_inputs pathname
      puts evaluate(commands)
    end

    # for specs
    if input
      @input = input
    end
  end

  def evaluate(commands)
    state = { enabled: true, start: 0, scans: [] }
    commands.each do |command|
      state = update_state(state, command)
    end
    # At the end, if state is enabled, add one more scan.
    state[:scans] << (state[:start]..@input.length) if state[:enabled]
    state[:scans].each.reduce(0) do |sum, scan_range|
      sum + evaluate_range(@input[scan_range].scan(MUL_MATCHER))
    end
  end

  def update_state(state, command)
    new_state = state.dup
    case command[0]
    when "do()"
      unless state[:enabled]
        new_state[:enabled] = true
        new_state[:start] = command[1]
      end
    when "don't()"
      if state[:enabled]
        new_state[:enabled] = false
        new_state[:start] = nil
        new_state[:scans] << (state[:start]..command[1])
      end
    else
      puts "Unknown command: #{command[0]}"
    end
    new_state
  end

  def read_inputs(pathname)
    file = File.open(pathname)
    @input = file.read
    scan_for_commands(@input)
  end

  def scan_for_commands(input)
    commands = []
    input.scan(DO_DONT_MATCHER) do |word|
      commands << [word, $~.offset(0)[0]]
    end
    commands
  end
end