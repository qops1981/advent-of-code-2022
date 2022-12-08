module Puzzel

  class Input

    attr_reader :values

    def initialize
      @values = File.read("../input.txt").split("\n")
    end

  end

  class Sample

    attr_reader :values

    def initialize
      @values = File.read("../sample.txt").split("\n")
    end

  end

end