# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'compare_linker_command/version'

Gem::Specification.new do |spec|
  spec.name          = "compare_linker_command"
  spec.version       = CompareLinkerCommand::VERSION
  spec.authors       = ["yoshihara"]
  spec.email         = ["yshr04hrk@gmail.com"]

  spec.summary       = "compare linker command"
  spec.description   = "compare linker command"
  spec.homepage      = "https://github.com/yoshihara/compare_linker_command"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "git", "~> 1.3.0"
  spec.add_dependency "octokit", "~> 4.7.0"
  spec.add_dependency "compare_linker", "~> 1.3.8"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
