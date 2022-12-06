#! /usr/bin/env ruby

require_relative 'puzzel'

sample = Puzzel::Sample.new.values
input  = Puzzel::Input.new.values

class DataStream

  def initialize(stream)
    @stream = stream.chars
  end
  
  def start_of_packet()  first_uniq_window(4) end

  def start_of_message() first_uniq_window(14) end

  private

  def first_uniq_window(window, pos = 0)
    until pos == (@stream.length - 1) do
      return pos + window if uniq?(@stream[pos,window])
      pos += 1
    end
  end

  def uniq?(window)
    window == window.uniq
  end

end

# Part 1

puts

sample.each_with_index do |s, x|
  printf(
    "Day 06: Part 1: [Sample %02d]: Start-of-Packet: %6d\n",
    x, DataStream.new(s).start_of_packet
  )
end

puts

printf(
  "Day 06: Part 1: [Input  %02d]: Start-of-Packet: %6d\n",
  1, DataStream.new(input.first).start_of_packet
)

# Part 2

puts

sample.each_with_index do |s, x|
  printf(
    "Day 06: Part 2: [Sample %02d]: Start-of-Message: %6d\n",
    x, DataStream.new(s).start_of_message
  )
end

puts

printf(
  "Day 06: Part 2: [Input  %02d]: Start-of-Message: %6d\n",
  1, DataStream.new(input.first).start_of_message
)