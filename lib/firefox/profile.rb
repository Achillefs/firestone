module Firefox
  class Profile
    attr_accessor :prefs, :addons
    
    def initialize path
      @prefs = Prefs.new(File.join(path,'prefs.js'))
      @addons = Addons.new(File.join(path,'extensions'))
    end
  end
end