# frozen_string_literal: true

class MerkleTree
  # An object to hold one-time signature
  # @api private
  class Leaf
    include Comparable

    attr_reader :height

    attr_accessor :value

    attr_reader :left_index

    attr_reader :right_index

    def self.build(value, position, digest: MerkleTree.default_digest)
      new(digest.(value), position, position)
    end

    # Create a leaf node
    #
    # @api private
    def initialize(value, left_index, right_index)
      @value = value
      @left_index = left_index
      @right_index = right_index
      @height = 0
    end

    def leaf?
      true
    end

    def include?(index)
      (left_index..right_index).cover?(index)
    end

    def size
      1
    end

    def <=>(other)
      value <=> other.value &&
        left_index <=> other.left_index &&
        right_index <=> other.right_index
    end

    def to_h
      { value: value }
    end

    def to_s(indent = "")
      indent + value
    end
  end # Leaf
end # MerkleTree
