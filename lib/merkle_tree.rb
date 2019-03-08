# frozen_string_literal: true

require 'openssl'
require 'English'

require_relative 'merkle_tree/leaf'
require_relative 'merkle_tree/node'
require_relative 'merkle_tree/version'

class MerkleTree
  # The tree root node
  attr_reader :root

  # All the leaf nodes
  attr_reader :leaves

  # The number of tree leaves
  #
  # @return [Integer]
  #
  # @api public
  attr_reader :width

  # The one way hash function
  attr_reader :digest

  # The default hash function using SHA 256
  #
  # @return [Proc]
  #
  # @api public
  def self.default_digest
    ->(val) { OpenSSL::Digest::SHA256.hexdigest(val) }
  end

  # Create a new Merkle Tree
  #
  # @example
  #   MerkleTree.new("L1", "L2", "L3", "L4")
  #
  # @param [Array[String]] messages
  #   the message to digest
  # @param [Proc] :digest
  #   the message digest algorithm
  #
  # @api public
  def initialize(*messages, digest: MerkleTree.default_digest)
    @root   = Node::EMPTY
    @width  = 0
    @digest = digest
    @leaves = to_leaves(*messages)
    @width  = @leaves.size
    @root   = build(@leaves)
  end

  # Convert messages to leaf data types
  #
  # @param [Array[String]] messages
  #   the message to digest
  #
  # @api private
  def to_leaves(*messages)
    if messages.size.odd?
      messages << messages.last.dup
    end

    messages.each_with_index.map do |msg, pos|
      Leaf.build(msg, pos, digest: digest)
    end
  end

  # Check if this tree has any messages
  #
  # @api public
  def empty?
    @root == Node::EMPTY
  end

  # The tree height
  #
  # @api public
  def height
    @root.height
  end

  # The number of nodes in this tree
  #
  # @api public
  def size
    @root.size
  end
  alias length size

  # Create subtree that contains message at index
  #
  # @return [Node]
  #   the root node of the subtree
  #
  # @api public
  def subtree(index)
    root.subtree(index)
  end

  # Calcualte the root value of this tree
  #
  # @param [Leaf] nodes
  #   the leaf nodes to build from
  #
  # @api private
  def build(nodes)
    return Node::EMPTY if nodes.empty?

    if nodes.size == 1
      return nodes[0]
    end

    parent_nodes = nodes.each_slice(2).map do |left, right|
      right = left if right.nil? # Duplicate odd nodes
      Node.build(left, right, digest: digest)
    end
    build(parent_nodes)
  end

  # Traverse tree from root to leaf collecting siblings hashes
  #
  # @param [Node] node
  # @param [Integer] index
  # @param [Array] path
  #
  # @return Array
  #
  # @api private
  def traverse(node, index, path)
    return path if node.leaf? || node == Node::EMPTY

    path << node.sibling(index)

    traverse(node.subtree(index), index, path)
  end

  # Create an authentication path required to authenticate leaf with index
  #
  # @param [Integer] index
  #
  # @return [Array[String,String]]
  #   an array of direction and hash tuples
  #
  # @api public
  def auth_path(index)
    traverse(root, index, [])
  end

  # Verifies that an authentication path exists from leaf to root
  #
  # @param [String] message
  #   the message to hash
  #
  # @param [Integer] index
  #   the index of the message to be authenticated
  #
  # @api public
  def include?(message, index)
    return false if empty?

    leaf_hash = digest.(message)

    hash = auth_path(index).reverse_each.reduce(leaf_hash) do |h, (dir, sibling)|
      digest.(dir == :left ? sibling + h : h + sibling)
    end

    hash == root.value
  end
  alias member? include?

  # Visit all direct children collecting child nodes
  #
  # @api private
  def visit(node, index, path)
    return path if node.leaf? || node == Node::EMPTY

    path << node.child(index)

    visit(node.subtree(index), index, path)
  end

  # The regeneration path from leaf to root
  #
  # @return [Node]
  #
  # @api public
  def regeneration_path(index)
    visit(@root, index, [@root])
  end

  # Update a leaf at index position
  #
  # @param [String] message
  #   the new message to hash
  # @param [Integer] index
  #   the index of the message to be rehashed
  #
  # @return [Leaf]
  #   the updated leaf
  #
  # @api public
  def update(message, index)
    return if empty?

    leaf_hash = digest.(message)

    regeneration_path(index).reverse_each do |node|
      if node.leaf?
        node.value = leaf_hash
      else
        node.update(digest)
      end
    end.last
  end

  # Hash representation of this tree
  #
  # @api public
  def to_h
    { root: root.to_h }
  end

  # String representation of this tree
  #
  # @api public
  def to_s(indent = '')
    root.to_s(indent)
  end
end # MerkleTree
