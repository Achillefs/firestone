require 'spec_helper'

describe Firefox::Profile do
  before { @path = './spec/files/' }
  subject { Firefox::Profile }
  
  context '#inifile_path' do
    it { subject.inifile_path(:osx).should eq("/Users/#{ENV['USER']}/Library/Application Support/Firefox") }
    it { subject.inifile_path(:win).should eq(%{"C:/Documents and Settings/#{ENV['USER']}/Application Data/Mozilla/Firefox"}) }
    it { subject.inifile_path(:linux).should eq("/home/#{ENV['USER']}/.mozilla/firefox") }
  end
  
  context '#inifile' do
    before { Firefox::Profile.stub(:inifile_path).and_return('./spec/files/') }
    
    it { subject.inifile.should be_a(IniFile) }
    it { subject.inifile['General']['StartWithLastProfile'].should eq("1") }
  end
  
  context '#create' do
    before {
      @inifile = './spec/files/profiles.ini'
      @old_inifile = File.read(@inifile)
      @path = './spec/files/testprofile'
      Firefox::Profile.stub(:inifile_path).and_return('./spec/files/')
    }
    after { 
      FileUtils.rm_rf @path
      File.open(@inifile,'w') {|f| f.write(@old_inifile)}
    }
    subject { Firefox::Profile.create(@path) }
    
    it { subject.should be_a(Firefox::Profile) }
    
    it 'saves prefs on save' do
      subject.prefs.merge!({ :test => true })
      subject.save!
      
      n = Firefox::Profile.new(@path)
      n.prefs.prefs.should eq({ "test" => true })
    end
    
    it 'updates ini file' do
      subject
      inifile = IniFile.load(@inifile)
      inifile.sections.last.should eq('Profile6')
      inifile['Profile6']['Name'].should eq('testprofile')
    end
  end
  
  context "#destroy" do
    before { 
      @inifile = './spec/files/profiles.ini'
      @old_inifile = File.read(@inifile)
      Firefox::Profile.stub(:inifile_path).and_return('./spec/files/') }
    after { File.open(@inifile,'w') {|f| f.write(@old_inifile)} }
    
    it 'should reorder profiles' do
      subject.destroy(2240).should eq(true)
      subject.inifile.sections.size.should eq(6)
      subject.inifile.sections.include?('Profile5').should eq(false)
    end
  end
  
  context 'associations' do
    subject { Firefox::Profile.new(@path) }
    
    it { subject.prefs.should be_a(Firefox::Prefs) }
    it { subject.addons.should be_a(Firefox::Addons) }
  end
end