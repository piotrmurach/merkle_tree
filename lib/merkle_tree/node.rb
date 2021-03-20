# frozen_string_literal: true

class MerkleTree
  # Holds information about intermediate hashes
  # @api private
  class Node
    include Comparable

    UNDEFINED = Module.new

    attr_reader :value

    attr_accessor :left

    attr_accessor :right

    # The node height in the tree
    attr_reader :height

    # The sequential position in the tree
    attr_reader :left_index

    attr_reader :right_index

    def self.build(left, right, digest: MerkleTree.default_digest)
      value  = digest.(left.value + right.value)
      height = left.height + 1
      left_index  = left.left_index
      right_index = right.right_index

      new(value, left, right, height, left_index, right_index)
    end

    # Create a node
    #
    # @api private
    def initialize(value, left, right, height, left_index, right_index)
      @value  = value
      @left   = left
      @right  = right
      @height = height
      @left_index  = left_index
      @right_index = right_index
    end

    def leaf?
      false
    end

    def size
      left.size + 1 + right.size
    end

    def include?(index)
      (left_index..right_index).cover?(index)
    end

    def update(digest)
      @value = digest.(left.value + right.value)
    end

    def child(index)
      if left.include?(index)
        left
      else
        right.include?(index) ? right : EMPTY
      end
    end

    # Find sibling child node for the index
    def sibling(index)
      if left.include?(index)
        [:right, right.value]
      else
        right.include?(index) ? [:left, left.value] : EMPTY
      end
    end

    # Find subtree that matches the index
    def subtree(index)
      if left.include?(index)
        left
      else
        right.include?(index) ? right : EMPTY
      end
    end

    def <=>(other)
      value <=> other.value &&
        left_index <=> other.left_index &&
        right_index <=> other.right_index
    end

    def to_h
      { value: value, left: left.to_h, right: right.to_h }
    end

    def to_s(indent = "")
      indent + value.to_s + $RS +
        left.to_s(indent + "  ") + $RS +
        right.to_s(indent + "  ")
    end

    # An empty node used as placeholder
    # @api private
    class EmptyNode < Node
      def initialize
        @value  = ""
        @height = 0
        @left   = UNDEFINED
        @right  = UNDEFINED
        @left_index = UNDEFINED
        @right_index = UNDEFINED
      end

      def size
        0
      end

      def sibling(*)
        []
      end

      def subtree(*)
        {}
      end

      def to_s; end

      def to_h
        {}
      end
    end # EmptyNode

    EMPTY = EmptyNode.new.freeze
  end # Node
end # MerkleTree
