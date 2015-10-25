# encoding: utf-8

require File.expand_path('../lib/curio/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'curio'
  spec.version       = Curio::VERSION
  spec.authors       = ['Terje Larsen']
  spec.email         = ['terlar@gmail.com']
  spec.description   = 'Mixin for enumerable maps'
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/terlar/curio'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rubocop'
end
