# frozen_string_literal: true

RSpec.describe MerkleTree, "#size" do
  it "returns 0 when tree has no messages" do
    merkle_tree = MerkleTree.new

    expect(merkle_tree.size).to eq(0)
  end

  it "returns 15 when tree has 8 messages" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")

    expect(merkle_tree.size).to eq(15)
  end
end
