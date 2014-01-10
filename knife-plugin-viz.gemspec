# -*- encoding: utf-8 -*-
$:.push File.expand_path(File.join('..', 'lib'), __FILE__)

Gem::Specification.new do |s|
  s.name        = "knife-plugin-viz"
  s.version     = "0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Huff", "Grégoire Seux"]
  s.email       = ["g.seux@criteo.com"]
  s.summary     = "Vizualization plugin for knife"
  s.description = s.summary
  s.files        = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- test/{functional,unit}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
