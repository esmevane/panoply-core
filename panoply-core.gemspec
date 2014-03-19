# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'panoply/version'

Gem::Specification.new do |gem|
  gem.name          = "panoply-core"
  gem.version       = Panoply::VERSION
  gem.authors       = ["Joseph McCormick"]
  gem.email         = ["esmevane@gmail.com"]
  gem.description   = %q{Core functionality for Panoply}
  gem.summary       = %q{Gem abstracting the core features of Panoply}
  gem.homepage      = "http://www.github.com/esmevane/panoply-core"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "minitest", "~> 4.3"
  gem.add_development_dependency "pry", "~> 0.9"
  gem.add_development_dependency "simplecov", "~> 0.8"

  gem.add_runtime_dependency "sequel", "~> 4.7"
end