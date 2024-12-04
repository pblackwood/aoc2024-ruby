# frozen_string_literal: true
require 'rspec'
require_relative '../src/puzzle03'

describe 'Puzzle03' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  it 'can compare two integers' do
    puzzle3 = Puzzle03.new nil
    expect(puzzle3.compare_ints 1, 1).to eq(0)
    expect(puzzle3.compare_ints 1, 4).to eq(-1)
    expect(puzzle3.compare_ints 3, 1).to eq(1)
  end

  it 'can determine safety' do
    puzzle3 = Puzzle03.new nil
    expect(puzzle3.is_safe [1,2,3]).to be true
    expect(puzzle3.is_safe [1,2,5,6,7,8]).to be true # difference of 3
    expect(puzzle3.is_safe [1,2,6,7,8,9,10,11]).to be false # difference of 4
    expect(puzzle3.is_safe [1,2,2,3,4,5]).to be false # difference of 0
    expect(puzzle3.is_safe [1,2,3,4,3,2]).to be false # both increasing and decreasing
    expect(puzzle3.is_safe [9,8,7,6,5,4,3,2]).to be true
    expect(puzzle3.is_safe [9,6,4,3,2,1]).to be true # difference of 3
    expect(puzzle3.is_safe [9,5,4,3,2,1]).to be false # difference of 4
    expect(puzzle3.is_safe [9,8,4,5,6,7]).to be false # both decreasing and increasing
  end
end
