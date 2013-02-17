require "#{File.dirname(File.realpath(__FILE__))}/fondue"
%W{ version base prefs profile addons }.each { |r| require "#{File.dirname(File.realpath(__FILE__))}/firefox/#{r}" }
module Firefox
end