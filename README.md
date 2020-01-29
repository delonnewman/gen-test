![Ruby](https://github.com/delonnewman/gen-test/workflows/Ruby/badge.svg)
[![Gem Version](https://badge.fury.io/rb/gen-test.svg)](https://badge.fury.io/rb/gen-test)

Gen::Test
=========

Generative, property based testing for Ruby

Synopsis
========
    
```ruby
AddOne = lambda { |x| x + 1 }

class AddOneTest < Minitest::Test
  include Gen::Test

  def test_incremented_for_all_integers
    for_all Integer do |int|
      inc = AddOne[int]
      assert_equal(inc, int + 1)
    end
  end
end
```

Why?
====

Generative or property based testing is an approach to testing where tests are automatically generated from
defintions for properties of the system being tested. While slower, generative testing has much value for
unit, acceptance and integration testing over TDD and BDD.

For example, generative tests still have much value when they're written after your code, and when extensive
can be quite useful for integration testing.

[Others](https://www.youtube.com/watch?v=r5i_OiZw6Sw) [argue](http://www.quviq.com/products/quickcheck-for-c/)
this point well.

There seemed to be a need for a simple, extensible, implementation for Ruby, that isn't a DSL or a framework.
This module strives to serve that purpose, it's still very incomplete, but it's proven useful.

You can use Gen::Test along side other tests written in a different style and it's designed to be used with
other testing frameworks like [Minitest](https://github.com/seattlerb/minitest) and [Rspec](https://rspec.info/).

It's also extensible, defining a simple protocol for extensiblity. Just define a `generate` method that can
be called with no arguments and returns your generated data on any object and it can be used as a generator.

Many core objects have already been extended (see [lib/ext_core.rb](lib/ext_core.rb)). You can also make use
of `Gen::Generator` which is a Proc-like object that implements the `generate` method.

Install
=======

    > gem install gen-test

or, add

    gem 'gen-test'

to your Gemfile.

Extentions
==========

- [Contracts::Gen](https://github.com/delonnewman/contracts-gen), defines generators for most of
  contracts the [Contracts](https://github.com/egonSchiele/contracts.ruby) gem.

See Also
========

- For Clojure [test.check](https://github.com/clojure/test.check)
- For Haskell (the original version) [QuickCheck](https://hackage.haskell.org/package/QuickCheck)
- For Erlang (the most complete version) [QuickCheck](http://www.quviq.com/products/erlang-quickcheck/)

- There's quite a few different versions for [Ruby](https://rubygems.org/search?utf8=%E2%9C%93&query=quickcheck)
