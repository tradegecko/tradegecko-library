# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tradegecko/styles/version'

Gem::Specification.new do |spec|
  spec.name          = "tradegecko-styles"
  spec.version       = Tradegecko::Styles::VERSION
  spec.authors       = ["Wong Pei Yi"]
  spec.email         = ["wongpeiyi@gmail.com"]
  spec.summary       = %q{Shared styles library for TradeGecko apps}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/tradegecko/tradegecko-styles"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
