# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tradegecko/library/version'

Gem::Specification.new do |spec|
  spec.name          = "tradegecko-library"
  spec.version       = Tradegecko::Library::VERSION
  spec.authors       = ["Wong Pei Yi"]
  spec.email         = ["peter@tradegecko.com"]
  spec.summary       = %q{Shared styles and components library for TradeGecko apps}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/tradegecko/tradegecko-library"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
