# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/endoscope/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord-endoscope'
  spec.version       = ActiveRecord::Endoscope::VERSION
  spec.authors       = ['Toru KAWAMURA']
  spec.email         = ['tkawa@4bit.net']
  spec.description   = %q{Endoscope enables scope to apply to model instance}
  spec.summary       = %q{Endoscope enables scope to apply to model instance}
  spec.homepage      = 'https://github.com/tkawa/activerecord-endoscope'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 3.0.0'
  spec.add_dependency 'activesupport', '>= 3.0.0'
  spec.add_dependency 'arel_ruby'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'squeel'
end
