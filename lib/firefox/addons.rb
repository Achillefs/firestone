module Firefox
  # TODO: extension listing using <profile>/extensions.sqlite
  # TODO: extension installation using zip/zip
  # TODO: extension removal
  class Addons < Fondue::HashClass
    attr_accessor :path, :addons
    
    def initialize extension_path
      @path = extension_path
      @addons = {}
    end
  end
end