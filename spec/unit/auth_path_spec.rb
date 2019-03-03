# frozen_string_literal: true

RSpec.describe MerkleTree, '#auth_path' do
  it "fails to find authentication path for an index" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")

    expect(merkle_tree.auth_path(100)).to eq([MerkleTree::Node::EMPTY])
  end

  it "finds authentication path for an index" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")

    expect(merkle_tree.auth_path(2)).to eq([
      [:left,"f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c"],
      [:right,"4a5a97c6433c4c062457e9335709d57493e75527809d8a9586c141e591ac9f2c"]
    ])
  end
end
