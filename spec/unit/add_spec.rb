# frozen_string_literal: true

RSpec.describe MerkleTree, "#add" do
  it "adds one message" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
    expanded_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5")

    merkle_tree << "L5"

    expect(merkle_tree.leaves.size).to eq(expanded_tree.leaves.size)
    expect(merkle_tree.size).to eq(expanded_tree.size)
    expect(merkle_tree.root.value).to eq(expanded_tree.root.value)
  end

  it "adds even messages" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
    expanded_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6")

    merkle_tree.add("L5", "L6")

    expect(merkle_tree.leaves.size).to eq(expanded_tree.leaves.size)
    expect(merkle_tree.size).to eq(expanded_tree.size)
    expect(merkle_tree.root.value).to eq(expanded_tree.root.value)
  end

  it "adds messages double the size" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
    expanded_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")

    merkle_tree.add("L5", "L6", "L7", "L8")

    expect(merkle_tree.leaves.size).to eq(expanded_tree.leaves.size)
    expect(merkle_tree.root.value).to eq(expanded_tree.root.value)
    expect(merkle_tree.size).to eq(expanded_tree.size)
  end
end
