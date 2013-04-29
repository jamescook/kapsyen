require "kapsyen/caption"

module Kapsyen
  class Caption
    include Comparable

    attr_reader :number, :text

    def initialize(number, time_text, text)
      @number, @time_text, @text = number.to_i, time_text, text
    end

    def <=>(other)
      number <=> other.number
    end

    def ==(other)
      [number, timespan, text] == [other.number, other.timespan, other.text]
    end

    def inspect
      text
    end

    def timespan
      @timespan ||= Kapsyen::Timespan.new(@time_text)
    end
  end
end
