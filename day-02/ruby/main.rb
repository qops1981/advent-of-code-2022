#! /usr/bin/env ruby

require_relative 'puzzel'

sample = Puzzel::Sample.new.values
input  = Puzzel::Input.new.values

module Game

  class Play

    attr_reader :result

    def initialize(player_1:, player_2:)
      @player_1 = player_1
      @player_2 = player_2
      @result   = run
    end

    private

    def run
      case
      when hand(@player_1) == @player_2.beats
        Result::Win.new(@player_2)
      when hand(@player_1) == hand(@player_2)
        Result::Draw.new(@player_2)
      else
        Result::Loss.new(@player_2)
      end
    end

    def hand(c)
      c.class.name.split('::').last
    end

  end

  module Result

    class Loss

      attr_reader :score, :total

      def initialize(play)
        @score = 0
        @total = @score + play.score
      end

    end

    class Draw

      attr_reader :score, :total

      def initialize(play)
        @score = 3
        @total = @score + play.score
      end

    end

    class Win

      attr_reader :score, :total

      def initialize(play)
        @score = 6
        @total = @score + play.score
      end

    end

  end

  module RPS

    class Rock

      attr_reader :score

      def initialize()
        @score = 1
      end

      def beats
        "Scissors"
      end

    end

    class Paper

      attr_reader :score

      def initialize()
        @score = 2
      end

      def beats
        "Rock"
      end

    end

    class Scissors

      attr_reader :score

      def initialize()
        @score = 3
      end

      def beats
        "Paper"
      end

    end

  end

end

def play(hand)
  case hand
  when "A", "X"
    Game::RPS::Rock.new
  when "B", "Y"
    Game::RPS::Paper.new
  when "C", "Z"
    Game::RPS::Scissors.new
  end
end

# Part 1 Sample

sample_results = []

sample.each do |players|

  play_1, play_2 = players.split(" ")

  sample_results << Game::Play.new(player_1: play(play_1), player_2: play(play_2)).result

end

p sample_results.collect(&:total).inject(&:+)

# Part 1 Input

input_results = []

input.each do |players|

  play_1, play_2 = players.split(" ")

  input_results << Game::Play.new(player_1: play(play_1), player_2: play(play_2)).result

end

p input_results.collect(&:total).inject(&:+)

# Part 2 Sample

def counter(play, move)
  looser = play.beats
  draw   = play.class.name.split('::').last
  winner = (["Rock", "Paper", "Scissors"] - [looser, draw]).first
  case move
  when "X"
    eval("Game::RPS::#{looser}.new")
  when "Y"
    eval("Game::RPS::#{draw}.new")
  when "Z"
    eval("Game::RPS::#{winner}.new")
  end
end

sample_results = []

sample.each do |players|

  play_1, play_2 = players.split(" ")

  player_1 = play(play_1)

  sample_results << Game::Play.new(player_1: player_1, player_2: counter(player_1, play_2)).result

end

p sample_results.collect(&:total).inject(&:+)

# Part 2 Input

input_results = []

input.each do |players|

  play_1, play_2 = players.split(" ")

  player_1 = play(play_1)

  input_results << Game::Play.new(player_1: player_1, player_2: counter(player_1, play_2)).result

end

p input_results.collect(&:total).inject(&:+)