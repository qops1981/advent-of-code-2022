#! /usr/bin/env python

class Puzzel:
  def values(self):
    return open("../sample.txt", 'r').read().split("\n\n")

