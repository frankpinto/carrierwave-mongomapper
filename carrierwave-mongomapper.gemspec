# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "carrierwave-mongomapper/version"

Gem::Specification.new do |s|
  s.name        = "carrierwave-mongomapper"
  s.version     = Carrierwave::Mongomapper::VERSION
  s.authors     = ["Christopher Giroir"]
  s.email       = ["kelsin@valefor.com"]
  s.homepage    = "https://github.com/Kelsin/carrierwave-mongomapper"
  s.summary     = %q{MongoMapper ORM file for CarrierWave}
  s.description = %q{MongoMapper ORM file for CarrierWave}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'carrierwave'
  s.add_dependency 'mongo_mapper'
end
