# frozen_string_literal: true

RSpec.describe MerkleTree, "#update" do
  it "updates a leaf at index position with a new message" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
    updated_merkle_tree = MerkleTree.new("L1", "L2", "L3*", "L4")
    expected_leaf = MerkleTree::Leaf.build("L3*", 2)

    updated_leaf = merkle_tree.update("L3*", 2)

    expect(updated_leaf.value).to eq(expected_leaf.value)
    expect(merkle_tree.root.value).to eq(updated_merkle_tree.root.value)
  end

  it "updates a leaf in tree with 8 messages with a new message" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")
    updated_merkle_tree = MerkleTree.new("L1", "L2", "L3*", "L4", "L5", "L6", "L7", "L8")
    expected_leaf = MerkleTree::Leaf.build("L3*", 2)

    updated_leaf = merkle_tree.update("L3*", 2)

    expect(updated_leaf.value).to eq(expected_leaf.value)
    expect(merkle_tree.root.value).to eq(updated_merkle_tree.root.value)
  end
end
