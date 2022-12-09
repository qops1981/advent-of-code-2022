#! /usr/bin/env ruby

require_relative 'puzzel'

sample = Puzzel::Sample.new.values
input  = Puzzel::Input.new.values

class Forest
  def initialize(forest)
    @forest = forest.map {|z| z.chars.map(&:to_i)}
  end

  def tree_visible_any?(x, y)
    return true if [x, y].include?(0) || [x, y].include?(@forest.length - 1)

    y_axis = @forest[x]
    x_axis = @forest.map {|f| f[y]}

    [
      visible?(x_axis[0..(x-1)],  x_axis[x]), 
      visible?(x_axis[(x+1)..-1], x_axis[x]),
      visible?(y_axis[0..(y-1)],  y_axis[y]), 
      visible?(y_axis[(y+1)..-1], y_axis[y])
    ].any?
  end

  def scenic_score(x, y)
    return 0 if [x, y].include?(0) || [x, y].include?(@forest.length - 1)

    y_axis = @forest[x]
    x_axis = @forest.map {|f| f[y]}

    [
      visible_count(x_axis[0..(x-1)].reverse,  x_axis[x]), 
      visible_count(x_axis[(x+1)..-1], x_axis[x]),
      visible_count(y_axis[0..(y-1)].reverse,  y_axis[y]), 
      visible_count(y_axis[(y+1)..-1], y_axis[y])
    ].inject(&:*)
  end

  private

  def visible?(leading, current)
    leading.all? {|l| l < current}
  end

  def visible_count(leading, current, last = 0, count = 0)
    return count if leading.empty? || last >= current
    tree = leading.shift
    visible_count(leading, current, tree, count += 1)
  end
end

# # Part 1
# Sample

matrix = (0..(sample.length-1)).to_a.repeated_permutation(2).to_a
forest = Forest.new(sample)

printf(
  "Day 08: Part 1: [Sample]: Visible Trees: %4d\n",
  matrix.map {|tree| forest.tree_visible_any?(*tree)}.count(true)
)

# Input

matrix = (0..(input.length-1)).to_a.repeated_permutation(2).to_a
forest = Forest.new(input)

printf(
  "Day 08: Part 1:  [Input]: Visible Trees: %4d\n",
  matrix.map {|tree| forest.tree_visible_any?(*tree)}.count(true)
)

# # Part 1
# Sample

matrix = (0..(sample.length-1)).to_a.repeated_permutation(2).to_a
forest = Forest.new(sample)

printf(
  "Day 08: Part 2: [Sample]: Max Scenic Score: %7d\n",
  matrix.map {|tree| forest.scenic_score(*tree)}.max
)

# Input

matrix = (0..(input.length-1)).to_a.repeated_permutation(2).to_a
forest = Forest.new(input)

printf(
  "Day 08: Part 2:  [Input]: Max Scenic Score: %7d\n",
  matrix.map {|tree| forest.scenic_score(*tree)}.max
)