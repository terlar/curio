# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'curio/version'

Gem::Specification.new do |spec|
  spec.name          = 'curio'
  spec.version       = Curio::VERSION
  spec.authors       = ['Terje Larsen']
  spec.email         = ['terlar@gmail.com']
  spec.summary       = 'Mixin for enumerable maps'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/terlar/curio'
  spec.license       = 'MIT'

  spec.files            = `git ls-files`.split($RS)
  spec.test_files       = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths    = %w(lib)
  spec.extra_rdoc_files = %w(LICENSE README.md)

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'rubocop', '~> 0.35'
end
