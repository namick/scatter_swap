# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scatter_swap/version'

Gem::Specification.new do |gem|
  gem.name          = "scatter_swap"
  gem.version       = ScatterSwap::VERSION
  gem.authors       = ["Nathan Amick"]
  gem.email         = ["github@nathanamick.com"]
  gem.description   = %q{ScatterSwap is an integer hash function designed to have zero collisions, achieve avalanche, and be reversible.}
  gem.summary       = %q{Minimal perfect hash function for 10 digit integers}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
