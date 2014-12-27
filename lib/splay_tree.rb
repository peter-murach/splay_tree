# coding: utf-8

require 'splay_tree/node'
require 'splay_tree/version'

class SplayTree
  UndefinedValue = Module.new

  attr_accessor :default

  def initialize(default = UndefinedValue, &block)
    if !UndefinedValue.equal?(default) && block
      fail ArgumentError,
           'You need to pas seither argument or a block as a default value'
    end
    @root  = Node::EMPTY
    @subtree = Node.new(nil, nil)
    @default = default
    @default_block = block
  end

  # @api public
  def empty?
    @root == Node::EMPTY
  end

  # @api public
  def size
    @root.size
  end
  alias_method :length, :size

  # Insert a node into a tree with the given key and value
  # provided that the tree does not already contain the key.
  # The node becomes the root of the tree.
  #
  # @param [Object] key
  #   the key under which the node is inserted
  # @param [Object] value
  #   the value of the node inserted into the tree
  #
  # @return [Boolean]
  #   false if key already exists, true otherwise
  # @api public
  def []=(key, value)
    if @root.empty?
      @root = Node.new(key, value)
      return true
    end

    @root = @root.insert(key, value)

    splay(key)
  end
  alias_method :insert, :[]=

  # Find object by the key
  #
  # @param [Object] key
  #   the search key
  #
  # @api public
  def [](key)
    splay(key) unless @root.empty?

    return default_value if @root.key != key

    @root.value
  end
  alias_method :fetch, :[]

  # Check if tree contains a node with a matching key.
  #
  # @return [Boolean]
  #
  # @api public
  def key?(key)
    return false if @root.empty?
    splay(key)
    @root.key == key
  end

  # Delete a node specified by the key from the tree
  # given the tree contains a node with this key.
  # The deleted node value is returned. If the node
  # is not found a nil is returned.
  #
  # @param [Object] key
  #
  # @return [Object]
  #   the node's value under the key
  #
  # @api public
  def delete(key)
    return if empty?
    splay(key)
    return if @root.key != key
    deleted = @root
    right = @root.right
    @root = @root.left
    if @root.empty?
      @root = right
    else
      splay(key) # ensure empty right child
      @root.right = right
    end
    deleted.value
  end

  # Construct and return two trees t1 and t2, where
  # t1 contains items in t less than or equal to key,
  # and t2 contains all items in t greater than key.
  #
  # @param [Object] key
  #
  # @api public
  def split(key)
  end

  # Dump the tree structure in bracket format
  # (root left right)
  #
  # @api public
  def dump
    @root.dump || ''
  end

  private

  # @api private
  def default_value
    if @default != UndefinedValue
      @default
    elsif @default_block
      @default_block.call
    end
  end

  # Top-down splaying by breaking down the tree.
  #
  # @param [Object] key
  #   the key at which to splay
  #
  # @api private
  def splay(key)
    current = @root
    dummy = left = right = @subtree
    @subtree.left = @subtree.right = Node::EMPTY
    loop do
      break if key == current.key
      if key < current.key
        break if current.left.empty?
        if key < current.left.key
          current = current.rotate_right
          break if current.left.empty?
        end
        right.left = current
        right = current
        current = current.left
      elsif key > current.key
        break if current.right.empty?
        if key > current.right.key
          current = current.rotate_left
          break if current.right.empty?
        end
        left.right = current
        left = current
        current = current.right
      end
    end
    left.right    = current.left
    right.left    = current.right
    current.left  = dummy.right
    current.right = dummy.left
    @root = current
  end
end # SplayTree
