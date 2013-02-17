require 'spec_helper'

describe Firefox::Profile do
  before { @path = './spec/files/' }
  
  context '#register_profile' do
    before { @path = './spec/files/testprofile' }
    after { FileUtils.rm_rf @path }
    subject { Firefox::Profile.create(@path) }
    it { subject.should be_a(Firefox::Profile) }
  end
  
  subject { Firefox::Profile.new(@path) }
  it { subject.prefs.should be_a(Firefox::Prefs) }
  it { subject.addons.should be_a(Firefox::Addons) }
end