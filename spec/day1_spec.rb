# frozen_string_literal: true
require 'rspec'
require_relative '../src/day1'

describe 'Day1Part2' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  it 'can create an element count hash' do
    arr = [4, 5, 6, 5]
    solution = Day1Part2.new nil, [], arr
    expect(solution.element_counts arr).to eq({ 4 => 1, 5 => 2, 6 => 1 })
  end

  it 'can retrieve an element count' do
    arr = [4, 5, 6, 5]
    solution = Day1Part2.new nil, [], arr
    count_hash = solution.element_counts arr
    expect(solution.element_count 1, count_hash).to eq(0)
    expect(solution.element_count 4, count_hash).to eq(1)
    expect(solution.element_count 5, count_hash).to eq(2)
  end

  it 'can compute the similarity score' do
    arr = [4, 5, 6, 5]
    solution = Day1Part2.new nil, [], arr
    count_hash = solution.element_counts arr
    expect(solution.similarity_score [1, 2], count_hash).to eq(0)
    expect(solution.similarity_score [1, 4], count_hash).to eq(4)
    expect(solution.similarity_score [1, 4, 5], count_hash).to eq(14)
    expect(solution.similarity_score [1, 4, 5, 5], count_hash).to eq(24)
  end
end
