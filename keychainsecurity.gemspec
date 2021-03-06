# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'keychainsecurity'

Gem::Specification.new do |s|
  s.name        = 'keychainsecurity'
  s.authors     = ['Krisna Pranav']
  s.email       = ''
  s.homepage    = 'https://github.com/krishpranav/keychainsecurity'
  s.version     = Security::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.summary     = 'A Ruby Library Interact with the macOS Keychain'

  s.files         = Dir['./**/*'].reject { |file| file =~ %r{\./(bin|log|pkg|script|spec|test|vendor)} }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.4.0'

  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-github'
  s.add_development_dependency 'rubocop'
end
