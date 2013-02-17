require 'spec_helper'

describe Firefox::Profile do
  before { @path = './spec/files/' }
  
  context '#register_profile' do
    before {
      @path = './spec/files/testprofile'
      Firefox::Profile.stub(:call_ff_create).and_return("Success: created profile 'test /Users/achilles/Scripts/serpclicker/profiles/' at '/Users/achilles/Scripts/serpclicker/profiles/prefs.js'")
    }
    after { FileUtils.rm_rf @path }
    subject { Firefox::Profile.create(@path) }
    
    it { subject.should be_a(Firefox::Profile) }
    it "saves prefs on save" do
      subject.prefs.merge!({ :test => true })
      subject.save!
      
      n = Firefox::Profile.new(@path)
      n.prefs.prefs.should eq({ "test" => true })
    end
  end
  
  subject { Firefox::Profile.new(@path) }
  it { subject.prefs.should be_a(Firefox::Prefs) }
  it { subject.addons.should be_a(Firefox::Addons) }
end