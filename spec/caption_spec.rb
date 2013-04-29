require "spec_helper"

describe Kapsyen::Caption do
  let(:filepath) { "./spec/fixtures/sample.srt" }
  subject { Kapsyen::Caption.new("42", "00:00:31,640 --> 00:00:34,200", "hello world") }

  its(:number) { should == 42 }
  its(:text) { should == "hello world" }
end
