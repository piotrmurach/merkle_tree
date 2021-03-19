# frozen_string_literal: true

RSpec.describe MerkleTree, "#leaves" do
  it "returns empty array when tree has no leaves" do
    merkle_tree = MerkleTree.new

    expect(merkle_tree.leaves).to be_empty
  end

  it "returns all leaves" do
    leaves = %w[L1 L2 L3 L4 L5 L6 L7 L8]
    merkle_tree = MerkleTree.new(*leaves)

    expect(merkle_tree.leaves.size).to eq(leaves.size)
  end
end
