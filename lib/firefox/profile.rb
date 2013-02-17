require 'fileutils'

module Firefox
  class ProfileInitializationError < Exception # :nodoc:
  end
  
  class Profile
    attr_accessor :prefs, :addons
    
    def initialize path
      @prefs = Prefs.new(File.join(path,'prefs.js'))
      @addons = Addons.new(File.join(path,'extensions'))
    end
    
    class << self
      # Register a new profile with firefox.
      # This is the right way to initialize a new profile.
      # It checks if the given directory exists, creates it if not
      def create path
        unless File.directory?(path)
          FileUtils.mkdir_p(path)
          FileUtils.touch(%W[prefs user].map { |f| File.join(path,"#{f}.js") })
        end
        realpath = 
        name = File.split(path).last
        response = %x[#{Base.bin_path} -CreateProfile \"#{name} #{File.realpath(path)}\" 2>&1]
        if response =~ /Error/
          raise ProfileInitializationError, response
        else
          self.new(path)
        end
      end
    end
  end
end