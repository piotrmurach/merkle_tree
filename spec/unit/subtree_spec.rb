# frozen_string_literal: true

RSpec.describe MerkleTree, '#subtree' do
  it "return empty node for non existent index" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")

    expect(merkle_tree.subtree(10)).to eq(MerkleTree::Node::EMPTY)
  end

  it "extracts subtree for a given index" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")

    expect(merkle_tree.subtree(2).to_h).to eq({
      value: "63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439",
      left: {
        value: "f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c",
        left: {
          value: "dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0",
        },
        right: {
          value: "d76354d8457898445bb69e0dc0dc95fb74cc3cf334f8c1859162a16ad0041f8d",
        }
      },
      right: {
        value: "8f75b0c1b3d1c0bb2eda264a43f8fdc5c72c853c95fbf2b01c1d5a3e12c6fe9a",
        left: {
          value: "842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80",
        },
        right: {
          value: "4a5a97c6433c4c062457e9335709d57493e75527809d8a9586c141e591ac9f2c"
        }
      }
    })
  end
end
