require 'spec_helper'

describe Firefox::Prefs do
  before { @read_path = './spec/files/prefs.js' }
  subject { Firefox::Prefs.new(@read_path) }
  it { subject.size.should eq(66) }
  it { subject["app.update.lastUpdateTime.addon-background-update-timer"].should eq(1360330995) }
  it { subject["intl.charsetmenu.browser.cache"].should eq('UTF-8') }
  it { subject.xpinstall.should eq('test') }
  it { subject.key?("intl.charsetmenu.browser.cache").should eq(true) }
  it { subject.each.should be_a(Enumerable) }
  
  context "write!" do
    before { @write_path = './spec/files/new_prefs.js' }
    after { FileUtils.rm @write_path }
    
    it 'can write config' do
      subject.write! @write_path
      File.read(@write_path).should eq(File.read(@read_path))
    end
  end
end