# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'email_test_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'email_test_helpers'
  spec.version       = EmailTestHelpers::VERSION
  spec.authors       = ["Zubin Henner"]
  spec.email         = ['zubin@rubidium.com.au']

  spec.summary       = %q{Simple acceptance test helpers for emails}
  spec.description   = <<-EOS
    EmailTestHelpers are a collection of lightweight helpers designed for acceptance tests.
    They add ability to find emails and click links in them.
  EOS
  spec.homepage      = 'https://github.com/zubin/email_test_helpers'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionmailer', '>= 3.0.0'
  spec.add_dependency 'capybara', '>= 1.0.0'

  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'cucumber', '~> 3.1.2'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-core', '~> 3.9.1'
  spec.add_development_dependency 'rspec-expectations'
  spec.add_development_dependency 'rspec-mocks'
end
