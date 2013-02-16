%W{ prefs version profile addons }.each { |r| require "#{File.dirname(File.realpath(__FILE__))}/firefox/#{r}" }
module Firefox
end