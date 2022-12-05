module Puzzel

  module Helper
    def stacks
      @values.first.split("\n")
    end

    def instructions
      @values.last.split("\n")
    end
  end

  class Input
    include Helper

    attr_reader :values

    def initialize
      @values = File.read("../input.txt").split("\n\n")
    end

  end

  class Sample
    include Helper

    attr_reader :values

    def initialize
      @values = File.read("../sample.txt").split("\n\n")
    end

  end

end