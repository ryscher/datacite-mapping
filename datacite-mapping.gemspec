# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'datacite/mapping/module_info'

Gem::Specification.new do |spec|
  spec.name          = Datacite::Mapping::NAME
  spec.version       = Datacite::Mapping::VERSION
  spec.authors       = ['David Moles']
  spec.email         = ['david.moles@ucop.edu']
  spec.summary       = 'Parses and generates Datacite XML documents'
  spec.description   = 'A gem for working with the Datacite XML format'
  spec.license       = 'MIT'

  origin_uri = URI(`git config --get remote.origin.url`.chomp)
  spec.homepage = URI::HTTP.build(host: origin_uri.host, path: origin_uri.path.chomp('.git')).to_s

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'xml-mapping_extensions', '~> 0.1', '>= 0.1.1'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'equivalent-xml', '~> 0.6.0'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'simplecov', '~> 0.9.2'
  spec.add_development_dependency 'simplecov-console', '~> 0.2.0'
  spec.add_development_dependency 'rubocop', '~> 0.32.1'
end
