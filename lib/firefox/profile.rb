require 'fileutils'

module Firefox
  class ProfileInitializationError < Exception # :nodoc:
  end
  
  # A Firefox profile. Allows basic creation and management of a profile. 
  # Supports preference setting and addon installation
  class Profile
    attr_accessor :prefs, :addons
    
    def initialize path
      @prefs = Prefs.new(File.join(path,'prefs.js'))
      @addons = Addons.new(File.join(path,'extensions'))
    end
    
    def save!
      self.prefs.write!
    end
    
    class << self
      # Register a new profile with firefox.
      # This is the right way to initialize a new profile.
      # It checks if the given directory exists, creates it if not
      def create path
        ini = inifile.dup
        FileUtils.mkdir_p(path) unless File.directory?(path)
        FileUtils.touch(%W[prefs user].map { |f| File.join(path,"#{f}.js") })
        
        last_entry_num = ini.sections.last.scan(/Profile([0-9]*)/).first.first.to_i
        ini["Profile#{last_entry_num+1}"] = {
          'Name' => File.split(path).last,
          'IsRelative' => 0,
          'Path' => path
        }
        ini.write
        new(path)
      end
      
      def destroy name
        deleted = false
        # delete profile form registry if name matches
        inifile.sections.each do |section|
          if inifile[section]['Name'] == name.to_s
            FileUtils.rm_rf inifile[section]['Path']
            inifile.delete_section(section)
            deleted = true
          end
        end
        
        # if we just deleted a profile, we need to renumber all other profiles
        # so that firefox doesn't get confused and cries
        if deleted
          new_content = {}
          i = 0
          inifile.sections.each do |s| 
            if s =~ /Profile[0-9]*/
              new_content["Profile#{i}"] = inifile[s]
              inifile.delete_section(s)
              i+=1
            end
          end
          inifile.merge!(new_content)
        end
        
        inifile.write
        deleted
      end
      
      def inifile reload = false
        @inifile = IniFile.load(File.join(inifile_path(Base.platform(RUBY_PLATFORM)),'profiles.ini')) if @inifile.nil? or reload
        @inifile
      end
      
      def inifile_path os
        case os
        when :osx
          File.join('/','Users',ENV['USER'],'Library','Application Support','Firefox')
        when :linux
          File.join('/','home',ENV['USER'],'.mozilla','firefox')
        when :win
          %{"#{File.join('C:','Documents and Settings',ENV['USER'],'Application Data','Mozilla','Firefox')}"}
        else
          raise UnsupportedOSError, "I don't really know what OS you're on, sorry"
        end
      end
    end
  end
end