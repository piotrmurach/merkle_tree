# frozen_string_literal: true

RSpec.describe MerkleTree::Leaf, '::build' do
  it "creates a leaf node" do
    leaf_node = MerkleTree::Leaf.build("L1", 0)

    expect(leaf_node.value).to eq("dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0")
  end
end
