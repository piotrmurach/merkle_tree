# frozen_string_literal: true

require "rspec-benchmark"

RSpec.describe "speed performance" do
  include RSpec::Benchmark::Matchers

  context "#new" do
    it "creates merkle trees in linear time" do
      sizes = bench_range(8, 8 << 12)
      messages = sizes.map { |n| Array.new(n) { "L#{n}" } }

      expect { |_, i|
        MerkleTree.new(*messages[i])
      }.to perform_linear.in_range(sizes)
    end

    it "allocates 6 objects for an empty merkle tree" do
      expect {
        MerkleTree.new
      }.to perform_allocation(6).objects
    end

    it "allocates 85 objects for a merkle tree with 8 messages" do
      messages = 8.times.each_with_object([]) { |i, acc| acc << "L#{i}" }

      expect {
        MerkleTree.new(*messages)
      }.to perform_allocation(85).objects
    end
  end

  context "#include?" do
    it "checks if a message belongs in logarithmic time" do
      sizes = bench_range(8, 8 << 12)
      trees = sizes.map do |n|
        messages = n.times.each_with_object([]) { |i, acc| acc << "L#{i}" }
        MerkleTree.new(*messages)
      end

      expect { |n, i|
        trees[i].include?("L#{n/2}", n/2)
      }.to perform_logarithmic.in_range(sizes).sample(100).times
    end
  end
end
