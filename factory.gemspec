# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'factory/version'

Gem::Specification.new do |spec|
  spec.name          = "factory"
  spec.version       = Factory::VERSION
  spec.authors       = ["Dmitriy Grechukha"]
  spec.email         = ["dmitriy.grechukha@gmail.com"]

  spec.summary       = %q{Class 'Factory'}
  spec.description   = %q{Class 'Factory' which will have the same behavior as 'Struct' class.}
  spec.homepage      = "https://github.com/timlar/rubygarage-factory"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "faker"
end
