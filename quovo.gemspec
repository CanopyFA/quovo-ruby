# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quovo/version'

Gem::Specification.new do |spec|
  spec.name          = "quovo"
  spec.version       = Quovo::VERSION
  spec.authors       = ['Alex Gorkunov', 'Nick Sidorov']
  spec.email         = ['alex.gorkunov@castle.co', 'nick.sidorov@castle.co']

  spec.summary       = "Quovo API client"
  spec.description   = "Quovo RESTful API client, configurable, thread-safe and well-tested"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
end
