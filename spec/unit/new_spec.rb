# frozen_string_literal: true

RSpec.describe MerkleTree, "#new" do
  it "creates tree from even number of messages" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")

    expect(merkle_tree.to_h).to eq({
      root: {
        value: "63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439",
        left: {
          value: "f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c",
          left: {
            value: "dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0"
          },
          right: {
            value: "d76354d8457898445bb69e0dc0dc95fb74cc3cf334f8c1859162a16ad0041f8d"
          }
        },
        right: {
          value: "8f75b0c1b3d1c0bb2eda264a43f8fdc5c72c853c95fbf2b01c1d5a3e12c6fe9a",
          left: {
            value: "842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80"
          },
          right: {
            value: "4a5a97c6433c4c062457e9335709d57493e75527809d8a9586c141e591ac9f2c"
          }
        }
      }
    })
  end

  it "creates tree from odd number of messages by duplicating the last message" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3")

    expect(merkle_tree.to_h).to eq({
      root: {
        value: "bdb1b6778b2923c883a078a6d8dbf40f99bb1a58bf5f650349f965bd8a222f43",
        left: {
          value: "f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c",
          left: {
            value: "dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0"
          },
          right: {
            value: "d76354d8457898445bb69e0dc0dc95fb74cc3cf334f8c1859162a16ad0041f8d"
          }
        },
        right: {
          value: "5ca8ce04894dcfaacfe7b77d5f003b355ca0df2e0055d6c9fa3b006a8e56a2ba",
          left: {
            value: "842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80"
          },
          right: {
            value: "842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80"
          }
        }
      }
    })
  end

  it "changes hashing function" do
    merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4",
                                 digest: ->(val) { "(#{val}h)" })

    expect(merkle_tree.to_h).to eq({
      root: {
        value: "(((L1h)(L2h)h)((L3h)(L4h)h)h)",
        left: {
          value: "((L1h)(L2h)h)",
          left: { value: "(L1h)" },
          right: { value: "(L2h)" }
        },
        right: {
          value: "((L3h)(L4h)h)",
          left: { value: "(L3h)" },
          right: { value: "(L4h)" }
        }
      }
    })
  end
end
