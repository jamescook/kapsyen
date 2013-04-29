# "00:00:31,640 --> 00:00:34,200"
require "strscan"

module Kapsyen
  class Timespan
    include Comparable

    class Component
      include Comparable

      attr_accessor :hour, :minute, :second, :millisecond

      def initialize(*args)
        @hour, @minute, @second, @millisecond = *args
      end

      def to_i
        ( hour * 3600 ) + ( minute * 60 ) + second + ( millisecond / 1000.0 )
      end

      def ==(other)
        to_i == other.to_i
      end

      def <=>(other)
        to_i <=> other.to_i
      end
    end

    attr_reader :start_time, :end_time

    def initialize(time_text)
      @scanner = StringScanner.new(time_text)
      process
    end

    def <=>(other)
      start_time <=> other.start_time
    end

    def ==(other)
      @start_time == other.start_time && @end_time == other.end_time
    end

    def inspect
      to_hash
    end

    private

    def process
      return if @start_time && @end_time

      hour        = scanner.scan(/\d{2}/).to_i
      scanner.skip /:/

      minute      = scanner.scan(/\d{2}/).to_i
      scanner.skip /:/

      second      = scanner.scan(/\d{2}/).to_i
      scanner.skip /,/

      millisecond = scanner.scan(/\d{3}/).to_f
      scanner.skip /\s-->\s/

      @start_time = Component.new(hour, minute, second, millisecond)
      hour          = scanner.scan(/\d{2}/).to_i
      scanner.skip /:/

      minute        = scanner.scan(/\d{2}/).to_i
      scanner.skip /:/

      second        = scanner.scan(/\d{2}/).to_i
      scanner.skip /,/

      millisecond   = scanner.scan(/\d{3}/).to_i
      @end_time = Component.new(hour, minute, second, millisecond)

      scanner.terminate
    end

    private

    def scanner
      @scanner
    end

  end
end
