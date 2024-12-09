# frozen_string_literal: true

class Day6
  def initialize(pathname = nil, grid = [])
    if pathname
      init_grid(pathname)
    end
    print "Part 1 solution: #{part1_solution}\n"
  end

  NORTH = "N"
  EAST = "E"
  SOUTH = "S"
  WEST = "W"

  def init_grid(pathname)
    @grid = []
    file = File.open(pathname)
    file.readlines(chomp: true).each_with_index do |line, row_index|
      @grid << line
      line.scan(/\^/) do |char|
        @position = Position.new(row_index, $~.offset(0)[0], NORTH)
      end
    end
    @grid_width = @grid[0].length
    @grid_height = @grid.length
    @position_count = 1
    @position_history = []
    record_position_history
  end

  def next_position
    new_pos = @position.dup
    case @position.direction
    when NORTH
      new_pos.row -= 1
    when EAST
      new_pos.col += 1
    when SOUTH
      new_pos.row += 1
    when WEST
      new_pos.col -= 1
    else
      puts "Invalid direction"
    end
    new_pos
  end

  def turn_right
    case @position.direction
    when NORTH
      EAST
    when EAST
      SOUTH
    when SOUTH
      WEST
    when WEST
      NORTH
    else
      puts "Invalid direction"
    end
  end

  def record_position_history
    @position_history << [@position.row, @position.col]
  end

  def part1_solution
    new_pos = next_position
    while new_pos.row >= 0 && new_pos.row < @grid_height && new_pos.col >= 0 && new_pos.col < @grid_width
      case @grid[new_pos.row][new_pos.col]
      when ".", "^"
        @position_count += 1 unless @position_history.include?([new_pos.row, new_pos.col])
        @position = new_pos
        record_position_history
      when "#"
        @position.direction = turn_right
      else
        puts "Invalid position"
      end
      # print "#{@position}\n"
      new_pos = next_position
    end
    @position_count
  end

end

class Position
  attr_accessor :row, :col, :direction

  def initialize(row, col, direction)
    @row = row
    @col = col
    @direction = direction
  end

  def ==(other)
    @row == other.row && @col == other.col && @direction == other.direction
  end

  def to_s
    "[#{row},#{col}] #{direction}"
  end
end
