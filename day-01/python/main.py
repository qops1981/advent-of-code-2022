#! /usr/bin/env python

import Sample
import Input
import numpy as np

sample = Sample.Puzzel()
input  = Input.Puzzel()

class Elf:
  def __init__(self, pack):
    self.pack = pack

  def total_calories(self):
    return np.sum(self.pack)

class Elves:
  def __init__(self, elves):
    self.elves = elves

  def max_calories_out_of(self, n):
    calorie_packs = [pack.total_calories() for pack in self.elves]
    return sorted(calorie_packs, reverse=True)[0:n]

  def max_calories_in_groups_of(self, n):
    return np.sum(self.max_calories_out_of(3))

# Part 1 - Sample

team = Elves([Elf([int(calorie) for calorie in v.splitlines()]) for v in sample.values()])

print(team.max_calories_out_of(1)[0])

# Part 2 - Sample

print(team.max_calories_in_groups_of(3))

# Part 1 - Input

team = Elves([Elf([int(calorie) for calorie in v.splitlines()]) for v in input.values()])

print(team.max_calories_out_of(1)[0])

# Part 2 - Input

print(team.max_calories_in_groups_of(3))