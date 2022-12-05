#! /usr/bin/env ruby

require_relative 'puzzel'

sample = Puzzel::Sample.new
input  = Puzzel::Input.new

class Stacks
  attr_reader :array

  def initialize(stacks)
    @array = deserialize(stacks)
  end

  def move(crane, quantity, origin, destination)
    payload = @array[origin - 1].pop(quantity)
    payload = payload.reverse if crane == 9000
    @array[destination - 1] = @array[destination - 1].concat(payload)
  end

  def tops
    @array.map { |s| s.last }.join()
  end

  def print
    @array.each { |s| printf("\033[K%s\n", s.join(" ")) }
  end

  private

  def deserialize(s)
    s.map { |l| columnize(l) }
      .transpose
      .map { |t| t.reverse.reject(&:empty?) }
  end

  def columnize(c)
    c.chars.each_slice(4).to_a
      .map { |s| s.join().strip }
  end

end

class Instruction
  attr_reader :move, :from, :to

  def initialize(instruction)
    @move, @from, @to = deserialize(instruction)
  end

  def to_a
    [@move, @from, @to]
  end

  private

  def deserialize(i)
    i.split(" ").each_slice(2).map { |s| s.last.to_i }
  end
end

class CargoYard
  def initialize(crane, stacks, instructions)
    @crane        = crane
    @stacks       = stacks
    @instructions = instructions
  end

  def run_verbose
    puts
    @stacks.print

    @instructions.each do |i|
      @stacks.move(@crane, *i.to_a)
      backup_cursor(@stacks.array.length)
      @stacks.print
      sleep 0.05
    end
    
    puts
    puts @stacks.tops.gsub(/\]|\[/, '')
  end

  def run
    @instructions.each do |i|
      @stacks.move(@crane, *i.to_a)
    end

    puts @stacks.tops.gsub(/\]|\[/, '')
  end

  private

  def backup_cursor(n)
    printf("\033[%dA", n)
  end

end

# Part 1: Sample

stacks        = Stacks.new(sample.stacks)
instructions  = sample.instructions.map { |i| Instruction.new(i) }

CargoYard.new(9000, stacks, instructions).run

# Part 1: Input

stacks        = Stacks.new(input.stacks)
instructions  = input.instructions.map { |i| Instruction.new(i) }

CargoYard.new(9000, stacks, instructions).run

# Part 2: Sample

stacks        = Stacks.new(sample.stacks)
instructions  = sample.instructions.map { |i| Instruction.new(i) }

CargoYard.new(9001, stacks, instructions).run

# Part 2: Input

stacks        = Stacks.new(input.stacks)
instructions  = input.instructions.map { |i| Instruction.new(i) }

CargoYard.new(9001, stacks, instructions).run