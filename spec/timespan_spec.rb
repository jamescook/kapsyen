require "spec_helper"

describe Kapsyen::Timespan do
  subject { Kapsyen::Timespan.new("00:00:31,640 --> 00:00:34,200") }

  its(:start_time) { should == Kapsyen::Timespan::Component.new(0,0,31,640.0) }
end
