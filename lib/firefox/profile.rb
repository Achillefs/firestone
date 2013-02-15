module Firefox
  class Profile
    attr_accessor :prefs
    
    def initialize path
      @prefs = Prefs.new(File.join(path,'prefs.js'))
    end
  end
end