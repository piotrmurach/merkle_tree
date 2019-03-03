# frozen_string_literal: true

RSpec.describe MerkleTree::Node, '::build' do
  it "combines two leaf nodes" do
    nodes = [
      MerkleTree::Leaf.build("L1", 0),
      MerkleTree::Leaf.build("L2", 1)
    ]

    node = MerkleTree::Node.build(*nodes)

    expect(node.value).to eq('f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c')
    expect(node.left).to eq(nodes[0])
    expect(node.right).to eq(nodes[1])
    expect(node.left_index).to eq(0)
    expect(node.right_index).to eq(1)
  end

  it "combines leaf node with empty node" do
    leaf = MerkleTree::Leaf.build("L1", 0)
    nodes = [
      leaf,
      MerkleTree::Node::EMPTY
    ]

    node = MerkleTree::Node.build(*nodes)

    expect(node.value).to eq("15253c068a787616f4a6580d34a099f5bde3991f771a5c8a7841638db7e69e24")

    expect(node.left_index).to eq(0)
    expect(node.right_index).to eq(MerkleTree::Node::UNDEFINED)
  end

  it "combines 2 nodes" do
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

    node = MerkleTree::Node.build(node_left, node_right)

    expect(node.value).to eq("63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439")
    expect(node.left).to eq(node_left)
    expect(node.right).to eq(node_right)
    expect(node.left_index).to eq(0)
    expect(node.right_index).to eq(3)
  end
end
