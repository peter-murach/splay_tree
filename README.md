# SplayTree

[![Gem Version](https://badge.fury.io/rb/splay_tree.svg)][gem]
[![Actions CI](https://github.com/piotrmurach/splay_tree/workflows/CI/badge.svg?branch=master)][gh_actions_ci]
[![Build status](https://ci.appveyor.com/api/projects/status/smfi5r38ihtn9gom?svg=true)][appveyor]
[![Maintainability](https://api.codeclimate.com/v1/badges/32d2351f6c349a58d8da/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/splay_tree/badge.svg?branch=master)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/splay_tree.svg)][inchpages]

[gem]: http://badge.fury.io/rb/splay_tree
[gh_actions_ci]: https://github.com/piotrmurach/splay_tree/actions?query=workflow%3ACI
[appveyor]: https://ci.appveyor.com/project/piotrmurach/splay-tree
[codeclimate]: https://codeclimate.com/github/piotrmurach/splay_tree/maintainability
[coverage]: https://coveralls.io/github/piotrmurach/splay_tree
[inchpages]: http://inch-ci.org/github/piotrmurach/splay_tree

> Self balancing binary tree that keeps lookup operations fast by optimizing frequently accessed keys. Useful for implementing caches and garbage collection algorithms.

## Features

* Familiar hash like access
* Easy instantiation with default value

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'splay_tree'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install splay_tree

## Contents

* [1. Usage](#1-usage)
  * [1.1 insert](#11-insert)
  * [1.2 fetch](#12-fetch)
  * [1.3 default](#13-default)
  * [1.4 delete](#14-delete)
  * [1.5 empty?](#15-empty)
  * [1.6 each](#16-each)

## 1. Usage

**SplayTree** operations are similar to that of `Hash`:

```ruby
tree = SplayTree.new
tree[:foo] = :bar

tree[:foo]   # => :bar
tree.size    # => 1
```

### 1.1 insert

In order to associate the value with the given key do:

```ruby
tree = SplayTree.new
tree["a"] = 1
tree["b"] = 2
```

Note: Inserted key will be subjected to splaying, which means the tree will be rearranged to help with quicker access on subsequent calls.

### 1.2 fetch

To retrieve a value from the tree corresponding to the key do:

```ruby
tree = SplayTree.new
tree["a"]    #  => nil

tree["a"] = 1
tree["a"]    #  => 1
```

Note: Frequently accessed keys will move nearer to the root where they can be accessed more quickly.

### 1.3 default

**SplayTree** allows you to set default value if key does not exist. This can be done during initialization or using `default` method:

```ruby
tree = SplayTree.new
tree.default          # => UndefinedValue

tree = SplayTree.new("foo")
tree.default          # => "foo"
tree["a"]             # => "foo"
```

You can also use block to set default value:

```ruby
tree = SplayTree.new
tree.default_proc    # => nil

tree = SplayTree.new { "foo" }
tree.default_proc    # => "foo"
tree["a"]            # => "foo"
```

### 1.4 delete

In order to remove an entry from the splay tree use `delete`. If the value is not found the default value is returned and `nil` otherwise.

```ruby
tree = SplayTree.new
tree['a'] = 1
tree.delete('a')   # => 1
tree.delete('z')   # => nil
```

### 1.5 empty?

To check if `tree` contains any elements call `empty?` like so:

```ruby
tree = SplayTree.new
tree.empty?   # => true

tree["a"] = 1
tree.empty?   # => false
```

### 1.6 each

In order to iterate over all tree nodes use `each` method like so:

```ruby
tree = SplayTree.new
tree['a'] = 1
tree['b'] = 2

tree.each { |key, value| puts "#{key}: #{value}" }
```

In addition you can use `each_key`, `each_value` to enumerate only keys and values respectively.

```ruby
tree.each_key { |key| ... }
tree.each_value { |value| ... }
```

If no block is provided, an enumerator is returned instead.

## Contributing

1. Fork it ( https://github.com/piotrmurach/splay_tree/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Code of Conduct

Everyone interacting in the SplayTree project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/splay_tree/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2014 Piotr Murach. See LICENSE for further details.
