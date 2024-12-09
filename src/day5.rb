# frozen_string_literal: true

class Day5
  def initialize(rules_pathname = nil, updates_pathname = nil, rules = [], updates = [])
    if rules_pathname
      init_ordering_rules(rules_pathname)
    end
    if updates_pathname
      init_updates(updates_pathname)
    end
    print "Part 1 solution: #{part1_solution}\n"
    print "Part 2 solution: #{part2_solution}\n"
  end

  def init_ordering_rules(pathname)
    @rules = {}
    file = File.open(pathname)
    file.readlines(chomp: true).each do |line|
      rule = line.split("|")
      pages = @rules[rule[0].to_i] ||= []
      pages << rule[1].to_i
    end
    # puts @rules
  end

  def init_updates(pathname)
    @correct_updates = []
    @incorrect_updates = []
    file = File.open(pathname)
    file.readlines(chomp: true).each do |line|
      update = line.split(",").map(&:to_i)
      sorted_update = update.sort do |a, b|
        compare_pages(a, b)
      end
      if update == sorted_update
        @correct_updates << sorted_update
      else
        @incorrect_updates << sorted_update
      end
    end
    # @updates.each do |u|
    #   puts u.join(",")
    # end
  end

  def compare_pages(a, b)
    rules = @rules[a]
    if rules && rules.include?(b)
      -1
    else
      rules = @rules[b]
      if rules && rules.include?(a)
        1
      else
        0
      end
    end
  end

  def part1_solution
    @correct_updates.each.reduce(0) do |sum, update|
      sum + update[update.length / 2]
    end
  end

  def part2_solution
    @incorrect_updates.each.reduce(0) do |sum, update|
      sum + update[update.length / 2]
    end
  end
end
