# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidelifter/version'

Gem::Specification.new do |spec|
  spec.name          = "sidelifter"
  spec.version       = Sidelifter::VERSION
  spec.authors       = ["Tim"]
  spec.email         = ["thogg4@gmail.com"]
  spec.summary       = 'Lift up cloud servers and docker containers'
  spec.description   = 'docker deployer'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['sidelifter']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'sshkit'
  spec.add_dependency 'thor'
  spec.add_dependency 'highline'

  # cloud libraries
  spec.add_dependency 'droplet_kit'

end
