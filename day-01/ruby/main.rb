#! /usr/bin/env ruby

module Puzzel

  module Helpers

    def split(delimiter, i = 0, segment = [], segments = [])

      at_end          = i == values.length
      is_match        = values[i] == delimiter
      at_end_or_match = is_match || at_end

      segments << segment if at_end_or_match

      return segments if at_end

      segment << values[i] unless is_match

      split(delimiter, i + 1, is_match ? [] : segment, segments)
    end

  end

  class Input
    include Helpers

    attr_reader :values

    def initialize
      @values = File.read("../input.txt").split("\n")
    end

  end

  class Sample
    include Helpers

    attr_reader :values

    def initialize
      @values = File.read("../sample.txt").split("\n")
    end

  end

end

Elf = Struct.new(:calories) do

  def total_calories
    calories.inject(&:+)
  end

end

Elves = Struct.new(:members) do

  def max_calories_out_of(n)
    members.collect(&:total_calories).max(n)
  end

  def max_calories_in_groups_of(n)
    max_calories_out_of(n).inject(&:+)
  end

end

# Part 1

values = Puzzel::Sample.new.split("")

elves = Elves.new(values.map {|packs| Elf.new(packs.map(&:to_i))})

puts "Part 1: [Sample] Most Cals: #{elves.max_calories_out_of(1).first}"

values = Puzzel::Input.new.split("")

elves = Elves.new(values.map {|packs| Elf.new(packs.map(&:to_i))})

puts "Part 1: [Input]  Most Cals: #{elves.max_calories_out_of(1).first}"

# Part 2

values = Puzzel::Sample.new.split("")

elves = Elves.new(values.map {|packs| Elf.new(packs.map(&:to_i))})

puts "Part 2: [Sample] Most Group of Cals: #{elves.max_calories_in_groups_of(3)}"

values = Puzzel::Input.new.split("")

elves = Elves.new(values.map {|packs| Elf.new(packs.map(&:to_i))})

puts "Part 2: [Input]  Most Group of Cals: #{elves.max_calories_in_groups_of(3)}"