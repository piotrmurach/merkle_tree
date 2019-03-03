# frozen_string_literal: true

RSpec.describe MerkleTree, '#height' do
  it "has no messages" do
    merkle_tree = MerkleTree.new

    expect(merkle_tree.height).to eq(0)
  end

  it "calculates tree height" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6")

    expect(merkle_tree.height).to eq(3)
  end
end
