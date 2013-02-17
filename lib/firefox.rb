require "#{File.dirname(File.realpath(__FILE__))}/fondue"
%W{ version base prefs profile addons installer }.each { |r| require "#{File.dirname(File.realpath(__FILE__))}/firefox/#{r}" }
module Firefox
  def self.install!
    installer = Firefox::Installer.new(Firefox::Base.platform(RUBY_PLATFORM))
  end
end