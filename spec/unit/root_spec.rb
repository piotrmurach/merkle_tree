# frozen_string_literal: true

RSpec.describe MerkleTree, '#root' do
  it "returns empty root when no messages" do
    merkle_tree = MerkleTree.new

    expect(merkle_tree.root).to eq(MerkleTree::Node::EMPTY)
  end

  it "calculates root signature" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")

    expect(merkle_tree.root.value).to eq("63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439")
  end
end
