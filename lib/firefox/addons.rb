module Firefox
  class Addons < Fondue::HashClass
    attr_accessor :path, :addons
    
    def initialize extension_path
      @path = extension_path
      @addons = {}
    end
  end
end