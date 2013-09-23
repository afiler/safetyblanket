safetyblanket
=============

A horrible demonstration of a new Ruby concept enabled by an innocent-seeming change in Ruby 2.1. Now that def returns the symbol name of the function defined, we can do all sorts of horrible horrible crufty things like add runtime "type safety" (bahahahhahahaha) to Ruby.

Exemplum gratis:

    require './safetyblanket'

    class Cruft
      extend SafetyBlanket
  
      int def foo(arg)
        puts arg
        arg
      end
    end

    cruft = Cruft.new
    cruft.foo 37
    cruft.foo 23
    cruft.foo "monkey"

Adding more "types" (bahahahhahahaha):

    module SafetyBlanket
      require 'set'
  
      def set(symbol)
        safetyblanketize symbol, Set
      end
    end

Todo:
* Add support for blocks for further "type safety" (bahahahhahahaha)
