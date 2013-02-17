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
        FileUtils.mkdir_p(path) unless File.directory?(path)
        FileUtils.touch(%W[prefs user].map { |f| File.join(path,"#{f}.js") })
        response = call_ff_create(path)
        if response =~ /Error/
          raise ProfileInitializationError, response
        else
          self.new(path)
        end
      end
      
      def call_ff_create path
        name = File.split(path).last
        %x[#{Base.bin_path} -CreateProfile \"#{name} #{File.realpath(path)}\" 2>&1]
      end
    end
  end
end