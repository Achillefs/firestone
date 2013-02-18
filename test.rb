require './lib/firefox'
i = Firefox::Installer.new(:osx,nil,'18.0.2', :dmg => '/var/folders/9p/n54h7qmx57351_by82lh77d40000gn/T/firefox.dmg')
i.install!