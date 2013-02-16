require 'spec_helper'

describe Firefox::Addons do
  before { @path = './spec/files/' }
  subject { Firefox::Addons.new(@path) }
  
  it { subject.size.should eq(0) }
end