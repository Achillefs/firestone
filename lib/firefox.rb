%W{ fondue inifile }.each { |r| require File.join(File.dirname(File.realpath(__FILE__)),r) }
%W{ version base prefs profile addons installer }.each { |r| require File.join(File.dirname(File.realpath(__FILE__)),'firefox',r) }

module Firefox
  def self.install!
    installer = Firefox::Installer.new(Firefox::Base.platform(RUBY_PLATFORM))
  end
end