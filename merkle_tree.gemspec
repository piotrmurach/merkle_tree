# frozen_string_literal: true

require_relative "lib/merkle_tree/version"

Gem::Specification.new do |spec|
  spec.name          = "merkle_tree"
  spec.version       = MerkleTree::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{A binary tree of one-time signatures known as a merkle tree.}
  spec.description   = %q{A binary tree of one-time singatures known as a merkle tree. Often used in distributed systems such as Git, Cassandra or Bitcoin for efficiently summarizing sets of data.}
  spec.homepage      = "https://github.com/piotrmurach/merkle_tree"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata)
    spec.metadata["bug_tracker_uri"] = "https://github.com/piotrmurach/merkle_tree/issues"
    spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/merkle_tree/blob/master/CHANGELOG.md"
    spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/merkle_tree"
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/merkle_tree"
  end
  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.0.0")

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"
end
