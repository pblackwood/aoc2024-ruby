# frozen_string_literal: true
require 'rspec'
require_relative '../src/day3_part1'

describe 'Day3Part1' do

  solution = Day3Part1.new nil

  before do
    solution = Day3Part1.new nil
  end

  after do
    # Do nothing
  end

  it 'can multiply 2 numbers' do
    expect(solution.mul(7, 6)).to eq(42)
  end

  it 'can evaluate many mul expressions' do
    expect(solution.evaluate(%w[mul(7,6) mul(10,100)])).to eq(1042)
  end
end
