lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'splay_tree/version'

Gem::Specification.new do |spec|
  spec.name          = "splay_tree"
  spec.version       = SplayTree::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["me@piotrmurach.com"]
  spec.summary       = %q{A self-balancing binary tree with amortized access.}
  spec.description   = %q{Self balancing binary tree that keeps lookup operations fast by optimizing frequently accessed keys. Useful for implementing caches and garbage collection algorithms.}
  spec.homepage      = "https://github.com/piotrmurach/splay_tree"
  spec.license       = "MIT"

  spec.files         = Dir['{lib,spec,benchmarks}/**/*.rb']
  spec.files        += Dir['tasks/*', 'splay_tree.gemspec']
  spec.files        += Dir['README.md', 'CHANGELOG.md', 'LICENSE.txt', 'Rakefile']
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
