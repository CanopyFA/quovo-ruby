# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quovo/version'

Gem::Specification.new do |spec|
  spec.name          = 'quovo'
  spec.version       = Quovo::VERSION
  spec.authors       = ['Alex Gorkunov', 'Nick Sidorov']
  spec.email         = ['alexander.gorkunov@gmail.com', 'theindiefly@gmail.com']
  spec.homepage      = 'https://github.com/CanopyFA/quovo-ruby'

  spec.summary       = 'Quovo API client'
  spec.description   = 'Quovo RESTful API client, configurable, thread-safe and well-tested'
  spec.license       = 'MIT'

  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0'
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(tests|bin|)/}) || f[0] == '.'
  end
end
