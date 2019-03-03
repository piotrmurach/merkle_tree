# frozen_string_literal: true

RSpec.describe MerkleTree, '#include?' do
  it "checks message inclusion in an empty tree" do
    merkle_tree = MerkleTree.new

    expect(merkle_tree.include?("L3", 2)).to eq(false)
  end

  it "checks valid message inclusion in 4 signatures tree" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")

    expect(merkle_tree.include?("L3", 2)).to eq(true)
  end

  it "checks valid message inclusion in 8 signatures tree" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")

    expect(merkle_tree.include?("L5", 4)).to eq(true)
  end

  it "checks invalid message inclusion in 8 signatures tree" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")

    expect(merkle_tree.include?("invalid", 4)).to eq(false)
  end
end
