#! /usr/bin/env ruby

require_relative 'puzzel'

sample = Puzzel::Sample.new.values
input  = Puzzel::Input.new.values

class Item
  attr_reader :item, :priority

  def initialize(item)
    @item     = item
    @priority = score
  end

  private

  def score
    value = ('a'..'z').to_a.index(@item.downcase) + 1
    is_upper? ? value + 26 : value
  end

  def is_upper?
    @item == @item.upcase
  end
end

class Rucksack
  attr_reader :items

  def initialize(items)
    @items = items.chars
    @compartment_1, @compartment_2 = compartments
  end

  def common_items
    (@compartment_1 & @compartment_2).map do |i|
      Item.new(i)
    end
  end

  private

  def compartments
    @items.each_slice( (@items.size/2.0).round ).to_a
  end
end

class Team
  attr_reader :badge

  def initialize(rucksacks)
    @rucksacks = rucksacks
    @badge     = common_item
  end

  private

  def common_item
    Item.new(@rucksacks.collect(&:items).inject(&:&).first)
  end

end

# Part 1

items = sample.map { |items| Rucksack.new(items).common_items }.flatten
printf("Day 03, Sample, Part 1: %d\n", items.collect(&:priority).inject(&:+))

items = input.map { |items| Rucksack.new(items).common_items }.flatten
printf("Day 03, Input,  Part 1: %d\n\n", items.collect(&:priority).inject(&:+))

# Part 2

items = sample.each_slice(3).map { |t| Team.new( t.map {|items| Rucksack.new(items) } ).badge }
printf("Day 03, Sample, Part 2: %d\n", items.collect(&:priority).inject(&:+))

items = input.each_slice(3).map { |t| Team.new( t.map {|items| Rucksack.new(items) } ).badge }
printf("Day 03, Input,  Part 2: %d\n", items.collect(&:priority).inject(&:+))