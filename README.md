# MerkleTree

[![Gem Version](https://badge.fury.io/rb/merkle_tree.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/merkle_tree.svg?branch=master)][travis]
[![Build status](https://ci.appveyor.com/api/projects/status/kcbi55cyq2wlfuhc?svg=true)][appveyor]
[![Maintainability](https://api.codeclimate.com/v1/badges/ce00667c8785a62cd892/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/piotrmurach/merkle_tree/badge.svg)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/merkle_tree.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/merkle_tree
[travis]: http://travis-ci.org/piotrmurach/merkle_tree
[appveyor]: https://ci.appveyor.com/project/piotrmurach/merkle-tree
[codeclimate]: https://codeclimate.com/github/piotrmurach/merkle_tree/maintainability
[coverage]: https://coveralls.io/r/piotrmurach/merkle_tree
[inchpages]: http://inch-ci.org/github/piotrmurach/merkle_tree

> A binary tree of one-time signatures known as merkle tree. Often used in distributed systems such as Git, Cassandra or Bitcoin for efficiently summarizing sets of data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'merkle_tree'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install merkle_tree

## Contents

* [1. Usage](#1-usage)
* [2. API](#2-api)
  * [2.1 root](#21-root)
  * [2.2 leaves](#22-leaves)
  * [2.3 subtree](#23-subtree)
  * [2.4 height](#24-height)
  * [2.5 size](#25-size)
  * [2.6 include?](#26-include)
  * [2.7 add](#27-add)
  * [2.8 update](#28-update)
  * [2.9 to_h](#29-to_h)
  * [2.10 to_s](#210-to_s)
  * [2.11 :digest](#211-digest)
* [3. See Also](#3-see-also)

## 1. Usage

Create a new *MerkleTree* by passing all the messages to be hashed:

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
```

Then you can use the tree to verify if a message belongs:

```ruby
merkle_tree.include?("L3", 2) # => true
```

Or change the message to a new content:

```ruby
merkle_tree.update("L3*", 2)
```

You can also check the tree height:

```ruby
merkle_tree.height # => 2
```

And how many nodes it has:

```ruby
merkle_tree.size # => 7
```

Finally, you can print the contents of the tree to see all the signatures:

```ruby
merkle_tree.to_s
# =>
# 63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439
#   f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c
#     dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0
#     d76354d8457898445bb69e0dc0dc95fb74cc3cf334f8c1859162a16ad0041f8d
#   8f75b0c1b3d1c0bb2eda264a43f8fdc5c72c853c95fbf2b01c1d5a3e12c6fe9a
#     842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80
#     4a5a97c6433c4c062457e9335709d57493e75527809d8a9586c141e591ac9f2c
```

## 2. API

### 2.1 root

To access the root node of the merkle tree use the `root` method that will return the tree structure with all its children and their signatures.

For example, given a tree with 4 messages

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
```

A full tree of one-time signatures will be available:

```ruby
merkle_tree.root
# =>
# MerkleTree::Node
#  @value="63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439"
#  @left=MerkleTree::Node
#    @value="f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c"
#    @left=MerkleTree::Leaf
#      @value="dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0"
#    @right=MerkleTree::Leaf
#      @value="d76354d8457898445bb69e0dc0dc95fb74cc3cf334f8c1859162a16ad0041f8d"
#  @right=MerkleTree::Node
#    @value="8f75b0c1b3d1c0bb2eda264a43f8fdc5c72c853c95fbf2b01c1d5a3e12c6fe9a"
#    @left=
#     MerkleTree::Leaf
#      @value="842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80"
#   @right=MerkleTree::Leaf
#     @value="4a5a97c6433c4c062457e9335709d57493e75527809d8a9586c141e591ac9f2c"
```

Since the root is a node you can retrieve it's signature using the `value` call:

```ruby
merkle_tree.root.value
# => "63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439"
```

### 2.2 leaves

You can access all the leaves and their one-time signatures using the `leaves` method:

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")

merkle_tree.leaves
# =>
# [
# <MerkleTree::Leaf @value="dffe8596...", @left_index=0, @right_index=0, @height=0>,
# <MerkleTree::Leaf @value="d76354d8...", @left_index=1, @right_index=1, @height=0>,
# <MerkleTree::Leaf @value="842983de...", @left_index=2, @right_index=2, @height=0>,
# <MerkleTree::Leaf @value="4a5a97c6...", @left_index=3, @right_index=3, @height=0>
# ]
```

### 2.3 subtree

To access a part of Merkle tree use `subtree` with the index of the one-time signature:

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")

merkle_tree.subtree(2).to_h
# =>
# {
#   value: "63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439",
#   left: {
#     value: "f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c",
#     left: { value: "dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0" },
#     right: { value: "d76354d8457898445bb69e0dc0dc95fb74cc3cf334f8c1859162a16ad0041f8d" }
#   },
#   right: {
#     value: "8f75b0c1b3d1c0bb2eda264a43f8fdc5c72c853c95fbf2b01c1d5a3e12c6fe9a",
#     left: { value: "842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80" },
#     right: { value: "4a5a97c6433c4c062457e9335709d57493e75527809d8a9586c141e591ac9f2c" }
#   }
# }
```

### 2.4 height

Every leaf in the tree has height 0 and the hash function of two leaves has height 1. So the tree has a total height of `H` if there is `N` leaves so that `N = 2^H`.


```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")
```

And since `8 = 2^3` then the height:

```ruby
merkle_tree.height # => 3
```

### 2.5 size

You can check total number of tree nodes with `size` or `length` calls:

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8")
merkle_tree.size
# => 15
```

### 2.6 include?

You can verify that a leaf belongs to merkle tree, namely, there is an authentication path or merkle path from the leaf to the root. This operation is `log2N` where N is number of leaves.

Given a tree with 4 messages:

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
```

To check if a message `L3` is contained in one of the one-time signatures, use the `include?` or `member?` method passing the message and position index:

```ruby
merkle_tree.include?("L3", 2) # => true
```

Conversely, if the message is not part of one-time signature at position indexed:

```ruby
merkle_tree.include?("invalid", 2) # => false
````

### 2.7 add

To add new messages to already existing tree use `add` or `<<` method. This action will create a new merkle root and increase tree height.

A merkle tree with 4 messages:

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
```

Will have the following properties:

```ruby
merkle_tree.leaves.size
# => 4
merkle_tree.height
# => 2
merkle_tree.size
# => 7
```

To add `L5` and `L6` messages do:

```ruby
merkle_tree.add("L5", "L6")
```

This will expand tree to have:

```ruby
merkle_tree.leaves.size
# => 6
merkle_tree.height
# => 3
merkle_tree.size
# => 15
```

### 2.8 update

You can replace any merkle tree message with a new one using the `update` call, which accepts a new message as a first argument and the index of the message to replace.

For example, given the tree:

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
```

To update message from `L3` to `L3*` do:

```ruby
merkle_tree.update("L3*", 2)
# =>
# #<MerkleTree::Leaf @value="e9a1dd00f5c5e848f6ca6d8660c5191d76ac5dd8867b7a8b08fb59c5ed2806db" ... >
```

### 2.9 to_h

You can dump the whole structure of the tree with `to_h` method:

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")

merkle_tree.to_h
# =>
# root: {
#   value: "63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439",
#   left: {
#     value: "f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c",
#     left: { value: "dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0" },
#     right: { value: "d76354d8457898445bb69e0dc0dc95fb74cc3cf334f8c1859162a16ad0041f8d" }
#   },
#   right: {
#     value: "8f75b0c1b3d1c0bb2eda264a43f8fdc5c72c853c95fbf2b01c1d5a3e12c6fe9a",
#     left: { value: "842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80" },
#     right: { value: "4a5a97c6433c4c062457e9335709d57493e75527809d8a9586c141e591ac9f2c" }
#   }
# }
```

### 2.10 to_s

```ruby
merkle_tree = MerkleTree.new("L1", "L2", "L3", "L4")
```

You can print merkle tree out to string:

```ruby
merkle_tree.to_s
# =>
# 63442ffc2d48a92c8ba746659331f273748ccede648b27f4eacf00cb0786c439
#   f2b92f33b56466fce14bc2ccf6a92f6edfcd8111446644c20221d6ae831dd67c
#     dffe8596427fc50e8f64654a609af134d45552f18bbecef90b31135a9e7acaa0
#     d76354d8457898445bb69e0dc0dc95fb74cc3cf334f8c1859162a16ad0041f8d
#   8f75b0c1b3d1c0bb2eda264a43f8fdc5c72c853c95fbf2b01c1d5a3e12c6fe9a
#     842983de8fb1d277a3fad5c8295c7a14317c458718a10c5a35b23e7f992a5c80
#     4a5a97c6433c4c062457e9335709d57493e75527809d8a9586c141e591ac9f2c
```

### 2.11 `:digest`

By default the `SHA-256` is used to create one-time signatures using Ruby's `openssl` package. You can see different [OpenSSl::Digest](https://ruby-doc.org/stdlib-2.6.1/libdoc/openssl/rdoc/OpenSSL/Digest.html).  

To provide your own algorithm use the `:digest` keyword and as value a lambda that will produce message hash. For example, to use `SHA-512` message digest algorithm do:

```ruby
MerkleTree.new("L1",..., digest: -> (val) { OpenSSL::Digest::SHA256.hexdigest(val) })
```

## 3. See Also

- [splay_tree](https://github.com/piotrmurach/splay_tree) – A self-balancing binary tree with amortised access.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/merkle_tree. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MerkleTree project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/merkle_tree/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2019 Piotr Murach. See [LICENSE.txt](https://github.com/piotrmurach/tty-pie_chart/blob/master/LICENSE.txt) for further details.
