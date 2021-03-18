# frozen_string_literal: true

require "rspec-benchmark"

RSpec.describe "speed performance" do
  include RSpec::Benchmark::Matchers

  it "creates merkle trees in linear time" do
    messages = bench_range(8, 8 << 12).map do |n|
      Array.new(n) { "L#{n}" }
    end

    expect { |n, i|
      MerkleTree.new(*messages[i])
    }.to perform_linear.in_range(8, 8 << 12)
  end

  it "checks if a message belongs in logarithmic time" do
    trees = []
    bench_range(8, 8 << 12).each do |n|
      messages = []
      n.times { |i| messages << "L#{i}" }
      trees << MerkleTree.new(*messages)
    end

    expect { |n, i|
      trees[i].include?("L#{n/2}", n/2)
    }.to perform_logarithmic.in_range(8, 8 << 12).sample(100).times
  end
end
