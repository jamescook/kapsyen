module Kapsyen
  class CaptionCollection
    include Enumerable

    def add(caption)
      set.add(caption)
    end

    def inspect
      "<Kapsyen::CaptionCollection>"
    end

    def each
      set.each {|caption| yield caption }
    end

    def ==(other)
      to_a == other.to_a
    end

    private

    def set
      @set ||= SortedSet.new
    end
  end
end
