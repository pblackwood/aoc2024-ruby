# frozen_string_literal: true

class Day4
  attr_reader :root_nodes

  def initialize(pathname = nil, grid = [])
    if pathname
      $grid = read_input(pathname)
    elsif !grid.empty?
      # useful for testing
      $grid = grid
    end
    $grid_width = $grid[0].length
    $grid_height = $grid.length
    @root_nodes = init_root_nodes
    # @root_nodes.each do |node|
    #   node.print_all
    # end
    puts @root_nodes.each.reduce(0) { |sum, node| sum + node.traverse }
  end

  def read_input(pathname)
    file = File.open(pathname)
    file.readlines(chomp: true)
  end

  def add_root_node(node)
    @root_nodes << node
  end

  def init_root_nodes
    root_nodes = []
    $grid.each_with_index do |row, row_index|
      row.scan("X") do |x|
        root_nodes << Node.new(x, Coordinates.new(row_index, $~.offset(0)[0]))
      end
    end
    root_nodes
  end

end

class Coordinates
  attr_reader :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def ==(other)
    @row == other.row && @col == other.col
  end

  def to_s
    "[#{row},#{col}]"
  end
end

class Node
  attr_reader :name, :coords, :direction, :children

  def initialize(name, coords, direction = nil)
    @name = name
    @coords = coords
    @direction = direction
    @children = init_children next_name
  end

  def next_name
    case @name
    when "X"
      "M"
    when "M"
      "A"
    when "A"
      "S"
    else
      nil
    end
  end

  def next_coord(direction)
    row = @coords.row
    col = @coords.col
    case direction
    when "N"
      row -= 1
    when "NE"
      row -= 1
      col += 1
    when "E"
      col += 1
    when "SE"
      row += 1
      col += 1
    when "S"
      row += 1
    when "SW"
      row += 1
      col -= 1
    when "W"
      col -= 1
    when "NW"
      row -= 1
      col -= 1
    else
      puts "Invalid direction"
    end
    if row >= 0 && row < $grid_height && col >= 0 && col < $grid_width
      Coordinates.new(row, col)
    end
  end

  def next_coords
    result = [
      { direction: "N", coords: Coordinates.new(@coords.row - 1, @coords.col) },
      { direction: "NE", coords: Coordinates.new(@coords.row - 1, @coords.col + 1) },
      { direction: "E", coords: Coordinates.new(@coords.row, @coords.col + 1) },
      { direction: "SE", coords: Coordinates.new(@coords.row + 1, @coords.col + 1) },
      { direction: "S", coords: Coordinates.new(@coords.row + 1, @coords.col) },
      { direction: "SW", coords: Coordinates.new(@coords.row + 1, @coords.col - 1) },
      { direction: "W", coords: Coordinates.new(@coords.row, @coords.col - 1) },
      { direction: "NW", coords: Coordinates.new(@coords.row - 1, @coords.col - 1) },
    ]
    result.select { |res| res[:coords].row >= 0 && res[:coords].row < $grid_height && res[:coords].col >= 0 && res[:coords].col < $grid_width }
  end

  def init_children(name)
    children = []
    if name
      if @direction
        if next_coord(@direction)
          next_in_line = next_coord(@direction)
          if $grid[next_in_line.row][next_in_line.col] == name
            children << Node.new(name, next_in_line, @direction)
          end
        end
      else
        next_coords.each do |n_c|
          if $grid[n_c[:coords].row][n_c[:coords].col] == name
            children << Node.new(name, n_c[:coords], n_c[:direction])
          end
        end
      end
    end
    children
  end

  def traverse
    if @name == "S"
      1
    else
      @children.each.reduce(0) do |sum, child|
        sum + child.traverse
      end
    end
  end

  def to_s
    "#{@name} #{@direction} #{@coords}"
  end

  def prefix
    case @name
    when "X"
      ""
    when "M"
      " "
    when "A"
      "  "
    when "S"
      "   "
    else
      ""
    end
  end

  def print_all
    print "\n#{prefix}#{self}"
    unless @children.empty?
      @children.each do |child|
        child.print_all
      end
    end
  end
end

