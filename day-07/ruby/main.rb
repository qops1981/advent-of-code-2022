#! /usr/bin/env ruby

require_relative 'puzzel'

sample = Puzzel::Sample.new.values
input  = Puzzel::Input.new.values

class XDirectory
  attr_reader :name, :contents
  attr_writer :contents

  def initialize(name, contents = [])
    @name = name
    @contents = contents
  end

  def size
    @contents.collect(&:size).inject(&:+)
  end
end

class XFile
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size.to_i
  end
end

class Volume
  attr_reader :stack

  def initialize(commands)
    @stack = construct(commands)
  end

  def directories(contents = @stack, flat = [], pos = 0)
    return flat if pos == contents.length
    if contents[pos].is_a?(XDirectory)
      flat << contents[pos]
      flat << directories(contents[pos].contents)
    end
    directories(contents, flat, pos += 1)
  end

  private

  def construct(commands, vol = [])
    return vol if commands.empty?

    t_output = commands.shift.split(" ")
    return vol if t_output.last == '..'

    if t_output[0,2] == ['$', 'cd']
      vol << XDirectory.new(t_output.last, construct(commands))
    end

    unless ['$', 'dir'].include?(t_output.first)
      vol << XFile.new(*t_output.reverse)
    end
    construct(commands, vol)
  end
end

sample_volume = Volume.new(sample)
input_volume  = Volume.new(input)

# # Part 1
# Sample
d = sample_volume.directories.flatten
      .collect(&:size).select {|s| s <= 100_000}.inject(&:+)
  
printf("Day 07: Part 1: [Sample]: Smaller Directories: %8d\n", d)

# Input
d = input_volume.directories.flatten
      .collect(&:size).select {|s| s <= 100_000}.inject(&:+)
  
printf("Day 07: Part 1:  [Input]: Smaller Directories: %8d\n", d)

# # Part 2
# Sample
capacity = 70_000_000
required = 30_000_000

used_space    = sample_volume.stack.first.size
unused_space  = capacity - used_space
overage       = required - unused_space

s = sample_volume.directories.flatten
    .collect(&:size).sort.detect {|s| s >= overage}

printf("Day 07: Part 2: [Sample]: Size to Remove: %8d\n", s)

# Input
used_space    = input_volume.stack.first.size
unused_space  = capacity - used_space
overage       = required - unused_space

s = input_volume.directories.flatten
      .collect(&:size).sort.detect {|s| s >= overage}

printf("Day 07: Part 2:  [Input]: Size to Remove: %8d\n", s)
