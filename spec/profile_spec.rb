require 'spec_helper'

describe Firefox::Profile do
  before { @path = './spec/files/' }
  subject { Firefox::Profile.new(@path) }
  it { subject.prefs.should be_a(Firefox::Prefs) }
end