Gen::Test
=========

Generative, property based testing for Ruby

Synopsis
========
    
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

Why?
====

Generative testing has much value for unit, acceptance and integration testing over TDD and BDD, while it's
value doesn't come for free.
[Others](https://www.youtube.com/watch?v=r5i_OiZw6Sw) [argue](http://www.quviq.com/products/quickcheck-for-c/)
this point well.

There seemed to be a need simple, extensible, implementation for Ruby, that wasn't a DSL or a framework. This
module is still very incomplete, but it's proven useful.

Install
=======

    > gem install gen-test

or, add

    gem 'gen-test'

to your Gemfile.

See Also
========

- For Clojure [test.check](https://github.com/clojure/test.check)
- For Haskell (the original version) [QuickCheck](https://hackage.haskell.org/package/QuickCheck)
- For Erlang (the most complete version) [QuickCheck](http://www.quviq.com/products/erlang-quickcheck/)

- There's quite a few different versions for [Ruby](https://rubygems.org/search?utf8=%E2%9C%93&query=quickcheck)
