# frozen_string_literal: true
require 'rspec'
require_relative '../src/puzzle04'

describe 'Puzzle04' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  it 'can determine safety' do
    puzzle4 = Puzzle04.new nil
    expect(puzzle4.is_safe [1,2,3]).to be true
    expect(puzzle4.is_safe [1,2,5,6,7,8]).to be true # difference of 3
    expect(puzzle4.is_safe [1,2,6,7,8,9,10,11]).to be false # difference of 4
    expect(puzzle4.is_safe [1,2,2,3,4,5]).to be false # difference of 0
    expect(puzzle4.is_safe [1,2,3,4,3,2]).to be false # both increasing and decreasing
    expect(puzzle4.is_safe [9,8,7,6,5,4,3,2]).to be true
    expect(puzzle4.is_safe [9,6,4,3,2,1]).to be true # difference of 3
    expect(puzzle4.is_safe [9,5,4,3,2,1]).to be false # difference of 4
    expect(puzzle4.is_safe [9,8,4,5,6,7]).to be false # both decreasing and increasing
  end

  it 'can create an array with one element missing (Part 2)' do
    puzzle4 = Puzzle04.new nil
    original = [1,2,3]
    expect(puzzle4.array_with_a_hole original, 0).to eq([2,3])
    expect(original).to eq([1,2,3])
    expect(puzzle4.array_with_a_hole original, 2).to eq([1,2])
    expect(original).to eq([1,2,3])
  end

  it 'can determine dampened safety (Part 2)' do
    puzzle4 = Puzzle04.new nil
    expect(puzzle4.is_safe [1,2,4,3,4]).to be false # both increasing and decreasing
    expect(puzzle4.is_dampened_safe [1,2,4,3,4]).to be true # safe if first 4 is removed
    expect(puzzle4.is_safe [1,2,2,3,4,5]).to be false # difference of 0
    expect(puzzle4.is_dampened_safe [1,2,2,3,4,5]).to be true # safe if either of the 2s is removed
  end
end
