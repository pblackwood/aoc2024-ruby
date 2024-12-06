# frozen_string_literal: true
require 'rspec'
require_relative '../src/day3'

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
    expect(solution.evaluate_range(%w[mul(7,6) mul(10,100)])).to eq(1042)
  end
end

describe 'Day3Part2' do
  solution = Day3Part2.new nil
  before do
    solution = Day3Part2.new nil
  end
  describe "current state is enabled, no scans" do
    state = { enabled: true, start: 12, scans: [] }
    it "can update state correctly for DO" do
      command = ["do()", 45]
      expect(solution.update_state(state, command)).to eq(state)
    end

    it "can update state correctly for DON'T" do
      command = ["don't()", 45]
      expect(solution.update_state(state, command)).to eq({ enabled: false, start: nil, scans: [(12..45)] })
    end
  end

  describe "current state is enabled, with scans" do
    state = { enabled: true, start: 46, scans: [0..34] }
    it "can update state correctly for DO" do
      command = ["do()", 88]
      expect(solution.update_state(state, command)).to eq(state)
    end

    it "can update state correctly for DON'T" do
      command = ["don't()", 88]
      expect(solution.update_state(state, command)).to eq({ enabled: false, start: nil, scans: [(0..34), (46..88)] })
    end
  end

  describe "current state is disabled, no scans" do
    state = { enabled: false, start: nil, scans: [] }
    it "can update state correctly for DO" do
      command = ["do()", 45]
      expect(solution.update_state(state, command)).to eq({ enabled: true, start: 45, scans: [] })
    end

    it "can update state correctly for DON'T" do
      command = ["don't()", 45]
      expect(solution.update_state(state, command)).to eq(state)
    end
  end

  describe "current state is disabled, with scans" do
    state = { enabled: false, start: nil, scans: [(0..34), (46..89)] }
    it "can update state correctly for DO" do
      command = ["do()", 123]
      expect(solution.update_state(state, command)).to eq({ enabled: true, start: 123, scans: [(0..34), (46..89)] })
    end

    it "can update state correctly for DON'T" do
      command = ["don't()", 45]
      expect(solution.update_state(state, command)).to eq(state)
    end
  end

  describe "Input" do
    solution = Day3Part2.new nil
    it "can scan input string for commands" do
      expect(solution.scan_for_commands("from()do()$&mul(602,165)")).to eq([["do()", 6]])
      expect(solution.scan_for_commands("from()do()dodon't()don'tdo()$&mul(602,165)")).to eq([["do()", 6], ["don't()", 12], ["do()", 24]])
      expect(solution.scan_for_commands("from here to eternity")).to eq([])
    end
  end

  describe "Evaluation" do
    it "can evaluate input string with no commands" do
      input = "from()mul(6,4)tomul(6,4)"
      solution = Day3Part2.new nil, input
      commands = solution.scan_for_commands(input)
      expect(solution.evaluate(commands)).to eq(48)
    end
    it "can evaluate input string with no ranges" do
      input = "from()don't()mul(6,4)tomul(6,4)"
      solution = Day3Part2.new nil, input
      commands = solution.scan_for_commands(input)
      expect(solution.evaluate(commands)).to eq(0)
    end
    it "can evaluate normal input string" do
      input = "from()here()mul(6,4)to()don't()mul(6,4)eternity()do()mul(6,4)"
      solution = Day3Part2.new nil, input
      commands = solution.scan_for_commands(input)
      expect(solution.evaluate(commands)).to eq(48)
    end
  end
end
