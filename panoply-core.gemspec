# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'panoply/core/version'

Gem::Specification.new do |gem|
  gem.name          = "panoply-core"
  gem.version       = Panoply::Core::VERSION
  gem.authors       = ["Joseph McCormick"]
  gem.email         = ["esmevane@gmail.com"]
  gem.description   = %q{Basic configuration loader}
  gem.summary       = %q{Load .yml and .json files into a basic interface}
  gem.homepage      = "http://www.github.com/esmevane/panoply-core"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "minitest", "~> 4.3"
  gem.add_development_dependency "pry", "~> 0.9"
  gem.add_development_dependency "simplecov", "~> 0.8"
end