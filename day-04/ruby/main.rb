#! /usr/bin/env ruby

require_relative 'puzzel'

sample = Puzzel::Sample.new.values
input  = Puzzel::Input.new.values

class Elf
  attr_reader :sections

  def initialize(sections)
    first, last = sections.split("-")
    @sections = (first..last).to_a
  end
end

class Pair
  attr_reader :overlapping

  def initialize(elves)
    elf_1, elf_2  = elves
    @assignment_1 = elf_1.sections
    @assignment_2 = elf_2.sections
    @overlapping  = @assignment_1 & @assignment_2
  end

  def redundant_assignment?
    [@assignment_1, @assignment_2].include?(@overlapping)
  end
end

# Part 1

pairs = sample.map { |pair| Pair.new(pair.split(",").map { |assignment| Elf.new(assignment) }) }
printf("Day 04, Sample, Part 1: %d\n", pairs.collect(&:redundant_assignment?).count(true))

pairs = input.map { |pair| Pair.new(pair.split(",").map { |assignment| Elf.new(assignment) }) }
printf("Day 04, Input,  Part 1: %d\n\n", pairs.collect(&:redundant_assignment?).count(true))

# Part 2

pairs = sample.map { |pair| Pair.new(pair.split(",").map { |assignment| Elf.new(assignment) }) }
printf("Day 04, Sample, Part 2: %d\n", pairs.collect(&:overlapping).select { |a| ! a.empty? }.length)

pairs = input.map { |pair| Pair.new(pair.split(",").map { |assignment| Elf.new(assignment) }) }
printf("Day 04, Input,  Part 2: %d\n", pairs.collect(&:overlapping).select { |a| ! a.empty? }.length)