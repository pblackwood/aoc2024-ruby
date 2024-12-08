# frozen_string_literal: true

class Day4Grid
  attr_reader :root_nodes

  def initialize(pathname = nil, grid = [])
    if pathname
      @grid = read_input(pathname)
    elsif !grid.empty?
      # useful for specs
      @grid = grid
    end
    @grid_width = @grid[0].length
    @grid_height = @grid.length
    puts solve
    # print "#{@grid_width} #{@grid_height} \n"
  end

  def read_input(pathname)
    file = File.open(pathname)
    file.readlines(chomp: true)
  end

  # The strategy is to walk an imaginary 3x3 grid over the grid, one column at a time,
  # then move to the next row, etc. Each time, check for one of the four possible
  # X-MAS'es and if found, increment the count.
  def solve
    xmas_count = 0
    (@grid_height - 2).times do |start_row|
      (@grid_width - 2).times do |start_col|
        mini_grid = target_square(start_row, start_col)
        # print "[#{start_row}, #{start_col}]"
        # print mini_grid
        # print "\n"
        xmas_count += test_square(mini_grid) ? 1 : 0
      end
    end
    xmas_count
  end

  VALID_3X3_CORNERS = [
    ["M M", "S S"],
    ["M S", "M S"],
    ["S S", "M M"],
    ["S M", "S M"]
  ]

  def target_square(start_row, start_col)
    [
      @grid[start_row][start_col, 3],
      @grid[start_row + 1][start_col, 3],
      @grid[start_row + 2][start_col, 3],
    ]
  end

  def test_square(target)
    target[1][1] == "A" &&
      VALID_3X3_CORNERS.any? do |valid|
        compare_corners(target, valid)
      end
  end

  def compare_corners(target_square, valid_square)
    target_square[0][0] == valid_square[0][0] &&
      target_square[0][2] == valid_square[0][2] &&
      target_square[2][0] == valid_square[1][0] &&
      target_square[2][2] == valid_square[1][2]
  end

end


