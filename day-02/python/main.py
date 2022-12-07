#! /usr/bin/env python

import Sample
import Input
import numpy as np

sample = Sample.Puzzel()
input  = Input.Puzzel()

HANDS = ["Rock", "Paper", "Scissors"]
TYPE  = ["Loss", "Draw", "Win"]

class Hand:
  def __init__(self):
    self.hand = str(self.__class__.__name__)

  def score(self):
    return { key: value for key, value in zip(HANDS, [1,2,3]) }[self.hand]

  def beats(self):
    return { key: value for key, value in zip(HANDS, np.roll(HANDS, 1)) }[self.hand]

class Rock(Hand):
  pass

class Paper(Hand):
  pass

class Scissors(Hand):
  pass

class ResultType:
  def __init__(self, play):
    self.play = play
    self.type = self.__class__.__name__

  def score(self):
    return { key: value for key, value in zip(TYPE, [0,3,6]) }[self.type]

  def total(self):
    return self.score() + self.play.score()

class Loss(ResultType):
  pass

class Draw(ResultType):
  pass

class Win(ResultType):
  pass

class Play:
  def __init__(self, player_1, player_2):
    self.player_1 = player_1
    self.player_2 = player_2
    self.result   = self.__run()

  def __run(self):
    if self.__is_win():
      return Win(self.player_2)
    elif self.__is_draw():
      return Draw(self.player_2)
    else:
      return Loss(self.player_2)

  def __is_win(self):
    return self.player_2.beats() == self.player_1.hand

  def __is_draw(self):
    return self.player_2.hand == self.player_1.hand

set_1 = ["A", "B", "C"]
set_2 = ["X", "Y", "Z"]

def index(value):
  if value in set_1: return set_1.index(value)
  if value in set_2: return set_2.index(value)

hands = [Rock(), Paper(), Scissors()]

# # Part 1
# Sample
results = [Play(*[hands[index(play)] for play in plays.split()]).result for plays in sample.values()]

print(
  "Day 02: Part 1: [Sample]: Total Score: ", 
  str(sum([result.total() for result in results]))
)

# Input
results = [Play(*[hands[index(play)] for play in plays.split()]).result for plays in input.values()]

print(
  "Day 02: Part 1:  [Input]: Total Score: ", 
  str(sum([result.total() for result in results]))
)

# # Part 2
# Sample
set_2 = list(np.roll(set_2, -1))

results = []

for plays in sample.values():
  pl = [index(ply) for ply in plays.split(" ")]
  results.append(Play(hands[pl[0]], np.roll(hands, -pl[1])[pl[0]]).result)

print(
  "Day 02: Part 1: [Sample]: Total Score: ", 
  str(sum([result.total() for result in results]))
)

# Input
results = []

for plays in input.values():
  pl = [index(ply) for ply in plays.split(" ")]
  results.append(Play(hands[pl[0]], np.roll(hands, -pl[1])[pl[0]]).result)

print(
  "Day 02: Part 1:  [Input]: Total Score: ", 
  str(sum([result.total() for result in results]))
)