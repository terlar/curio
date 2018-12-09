lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'curio/version'

Gem::Specification.new do |spec|
  spec.name          = 'curio'
  spec.version       = Curio::VERSION
  spec.authors       = ['Terje Larsen']
  spec.email         = ['terlar@gmail.com']
  spec.license       = 'MIT'

  spec.summary       = 'Mixin for enumerable maps'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/terlar/curio'

  spec.files            = `git ls-files -z`.split("\x0")
  spec.test_files       = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths    = %w[lib]
  spec.extra_rdoc_files = %w[LICENSE README.md]

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest', '~> 5.10'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rubocop', '~> 0.51'
end
