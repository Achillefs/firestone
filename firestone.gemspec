# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "firefox/version"

Gem::Specification.new do |s|
  s.name        = "firestone"
  s.version     = Firefox::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Achilles Charmpilas"]
  s.email       = ["ac@humbuckercode.co.uk"]
  s.homepage    = "http://humbuckercode.co.uk/licks/gems/firestone"
  s.summary     = %q{A collection of Firefox automation and programmatic management scripts in Ruby}
  s.description = %q{A collection of Firefox automation and programmatic management scripts in Ruby}

  s.rubyforge_project = "firestone"
  s.add_dependency 'progressbar'
  s.add_development_dependency 'rspec'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
