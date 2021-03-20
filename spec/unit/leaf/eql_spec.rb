# frozen_string_literal: true

RSpec.describe MerkleTree::Leaf, "#==" do
  it "compares two different leaves with the same message" do
    leaf_a = MerkleTree::Leaf.build("L1", 0)
    leaf_b = MerkleTree::Leaf.build("L1", 1)

    expect(leaf_a).to_not eq(leaf_b)
    expect(leaf_a).to be < leaf_b
  end

  it "compares successfully only with the same leaf" do
    leaf = MerkleTree::Leaf.build("L1", 0)

    expect(leaf).to eq(leaf)
  end

  it "orders leaves based on their values" do
    leaf_a = MerkleTree::Leaf.build("L1", 1)
    leaf_b = MerkleTree::Leaf.build("L2", 2)
    leaf_c = MerkleTree::Leaf.build("L3", 3)

    expect(leaf_a).to be < leaf_b
    expect(leaf_b).to be < leaf_c
    expect(leaf_b).to be_between(leaf_a, leaf_c)
  end
end
