# frozen_string_literal: true

RSpec.describe MerkleTree::Node, "#==" do
  it "compares two different nodes" do
    nodes_left = [
      MerkleTree::Leaf.build("L1", 0),
      MerkleTree::Leaf.build("L2", 1)
    ]

    nodes_right = [
      MerkleTree::Leaf.build("L3", 2),
      MerkleTree::Leaf.build("L4", 3)
    ]

    node_left = MerkleTree::Node.build(*nodes_left)
    node_right = MerkleTree::Node.build(*nodes_right)

    expect(node_left).to_not eq(node_right)
  end

  it "compares same node" do
    nodes = [
      MerkleTree::Leaf.build("L1", 0),
      MerkleTree::Leaf.build("L2", 1)
    ]

    node = MerkleTree::Node.build(*nodes)

    expect(node).to eq(node)
  end
end
