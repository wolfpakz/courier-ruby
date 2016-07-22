# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'courier/version'

Gem::Specification.new do |spec|
  spec.name          = "courier"
  spec.version       = Courier::VERSION
  spec.authors       = ["Dan Porter"]
  spec.email         = ["wolfpakz@gmail.com"]

  spec.summary       = %q{Simple, extensible, pub-sub client.}
  spec.description   = %q{Includes clients for AWS/SNS, logging only, and testing.}
  spec.homepage      = "https://github.com/wolfpakz/courier-ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://zinr5tbMAFC8yY9pn2Yz@push.fury.io"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk", "~> 2.4"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
