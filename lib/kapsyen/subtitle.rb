#Sample subtitle file
#=====================
#
#1
#00:00:31,640 --> 00:00:34,200
#[I amar prestar aen]
#another line
#

require "strscan"

module Kapsyen
  class Subtitle

    def self.from_file(filename)
      new File.read(filename, :mode => 'r:bom|utf-8').encode(:universal_newline => true)
    end

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def inspect
      "<Kapsyen::Subtitle>"
    end

    def captions
      @captions ||= CaptionCollection.new.tap do |set|
        until scanner.eos?
          number = scanner.scan(caption_number_regex)
          break if number.nil?

          skip_newline
          time = scanner.scan(timespan_regex)
          skip_newline
          text = ""

          until scanner.skip empty_line
            text << (scanner.scan(text_regex) + "\n")
            skip_newline
          end
          skip_newline

          set.add Caption.new(number, time, text)
        end

        scanner.terminate
      end
    end

    private
    
    def skip_newline
      scanner.skip(newline)
    end

    def scanner
      @scanner ||= StringScanner.new(data)
    end

    def caption_number_regex
      /^\d+/
    end

    def empty_line
      /^$/
    end

    def time_regex
      /\d\d:\d\d:\d\d,\d\d\d/
    end

    def timespan_regex
      /^#{time_regex}\s-->\s#{time_regex}$/
    end

    def text_regex
      /^.+$/
    end

    def newline
      /\n|\r\n/
    end
  end
end
