require "spec_helper"

describe Kapsyen::Subtitle do
  let(:filepath) { "./spec/fixtures/sample.srt" }
  let(:caption1) { Kapsyen::Caption.new("1", "00:00:31,640 --> 00:00:34,200", "[I amar prestar aen]\nanother line") }
  let(:caption2) { Kapsyen::Caption.new("2", "00:00:35,840 --> 00:00:36,200", "hi hi\nhello\nherp derp") }

  subject { Kapsyen::Subtitle.from_file(filepath) }

  it "has captions" do
    collection = Kapsyen::CaptionCollection.new
    collection.add caption1
    collection.add caption2

    subject.captions.should == collection
  end
end
