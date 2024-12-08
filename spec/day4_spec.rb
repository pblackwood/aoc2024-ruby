# frozen_string_literal: true
require 'rspec'
require_relative '../src/day4_tree'

describe 'Day4' do

  grid = %w[abcdef abcdef abcdef abcdef abcdef abcdef]
  solution = Day4Tree.new nil, grid

  before do
    solution = Day4Tree.new nil, grid
  end

  after do
    # Do nothing
  end

  describe 'Node' do
    describe 'Valid adjacent cells' do
      it 'can find the next cell moving in a given direction' do
        expected_next_cell = {
          N: [1, 4],
          S: [3, 4],
          E: [2, 5],
          W: [2, 3],
          NE: [1, 5],
          SE: [3, 5],
          SW: [3, 3],
          NW: [1, 3]
        }
        %w[N S E W NE SE SW NW].each do |direction|
          node = Node.new("x", Coordinates.new(2, 4), direction)
          expect(node.next_coord(direction)).to eq(Coordinates.new(expected_next_cell[direction.to_sym][0], expected_next_cell[direction.to_sym][1]))
        end
      end
    end
  end
end

