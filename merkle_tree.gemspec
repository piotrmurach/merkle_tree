lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "merkle_tree/version"

Gem::Specification.new do |spec|
  spec.name          = "merkle_tree"
  spec.version       = MerkleTree::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["me@piotrmurach.com"]

  spec.summary       = %q{A binary tree of one-time signatures known as a merkle tree.}
  spec.description   = %q{A binary tree of one-time singatures known as a merkle tree. Often used in distributed systems such as Git, Cassandra or Bitcoin for efficiently summarizing sets of data.}
  spec.homepage      = "https://github.com/piotrmurach/merkle_tree"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/merkle_tree"
    spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/merkle_tree/blob/master/CHANGELOG.md"
  end
  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"
end
