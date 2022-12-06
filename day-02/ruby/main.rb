#! /usr/bin/env ruby

require_relative 'puzzel'

sample = Puzzel::Sample.new.values
input  = Puzzel::Input.new.values

HANDS = ["Rock", "Paper", "Scissors"]
TYPE  = ["Loss", "Draw", "Win"]

module Game

  module Support

    def hand
      self.class.name.split('::').last
    end

  end

  class Play

    attr_reader :result

    def initialize(player_1, player_2)
      @player_1 = player_1
      @player_2 = player_2
      @result   = run
    end

    private

    def run
      case
      when win?
        Result::Win.new(@player_2)
      when draw?
        Result::Draw.new(@player_2)
      else
        Result::Loss.new(@player_2)
      end
    end

    def win?
      @player_2.beats == @player_1.hand
    end

    def draw?
      @player_2.hand == @player_1.hand
    end

  end

  module Result

    class Type
      include Support

      def initialize(play)
        @play = play
      end

      def score
        Hash[TYPE.zip([0,3,6])][hand]
      end

      def total
        score + @play.score
      end

    end

    class Loss < Type
    end

    class Draw < Type
    end

    class Win < Type
    end

  end

  module RPS

    class Hand
      include Support

      def score
        Hash[HANDS.zip([1,2,3])][hand]
      end

      def beats
        Hash[HANDS.zip(HANDS.rotate(2))][hand]
      end

    end

    class Rock < Hand
    end

    class Paper < Hand
    end

    class Scissors < Hand
    end

  end

end

hands = [Game::RPS::Rock.new, Game::RPS::Paper.new, Game::RPS::Scissors.new]

set_1 = ["A", "B", "C"]
set_2 = ["X", "Y", "Z"]

# # Part 1 Sample

results = sample.map do |players|
  Game::Play.new(
    *players.split(" ").map do |play| 
      hands[(set_1.index(play) || set_2.index(play))].clone
    end
  ).result
end

printf(
  "Day 02: Part 1: [Sample]: Total Score: %6d\n", 
  results.collect(&:total).inject(&:+)
)

# # Part 1 Input

results = input.map do |players|
  Game::Play.new(
    *players.split(" ").map do |play| 
      hands[(set_1.index(play) || set_2.index(play))].clone
    end
  ).result
end

printf(
  "Day 02: Part 1:  [Input]: Total Score: %6d\n", 
  results.collect(&:total).inject(&:+)
)

# # Part 2 Sample

set_2 = set_2.rotate(1)

results = sample.map do |players|
  p1, p2 = players.split(" ").map {|p0| (set_1.index(p0) || set_2.index(p0)) }
  Game::Play.new( hands[p1].clone, hands.rotate(p2)[p1].clone ).result
end

printf(
  "Day 02: Part 2: [Sample]: Total Score: %6d\n",
  results.collect(&:total).inject(&:+)
)

# # Part 2 Input

results = input.map do |players|
  p1, p2 = players.split(" ").map {|p0| (set_1.index(p0) || set_2.index(p0)) }
  Game::Play.new( hands[p1].clone, hands.rotate(p2)[p1].clone ).result
end

printf(
  "Day 02: Part 2:  [Input]: Total Score: %6d\n",
  results.collect(&:total).inject(&:+)
)
