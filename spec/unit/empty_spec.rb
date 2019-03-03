# frozen_string_literal: true

RSpec.describe MerkleTree, '#empty?' do
  it "returns true when tree has no messages" do
    merkle_tree = MerkleTree.new

    expect(merkle_tree.empty?).to eq(true)
  end

  it "returns false when tree has messages" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")

    expect(merkle_tree.empty?).to eq(false)
  end
end
