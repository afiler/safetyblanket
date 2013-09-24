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
      
      char def first_letter(arg)
        puts arg[0]
        arg[0]
      end
      
      void def null_factory(arg)
        puts arg
        nil
      end
    end

    cruft = Cruft.new
    cruft.foo 37
    cruft.null_factory "🏭"
    cruft.first_letter "pie"
    cruft.foo "monkey"
    
Will give:

    37
    ABBA
    🏭
    p
    20
    monkey
    (eval):10:in `foo': foo returned String instead of Fixnum (RuntimeError)
            from example.rb:59:in `<main>'

Adding more "types" (bahahahhahahaha):

    module SafetyBlanket
      require 'set'
  
      def set(symbol)
        safetyblanketize symbol, Set
      end
      
      def Palindrome(symbol)
        safetyblanketize symbol, String do |str|
          str == str.reverse
        end
      end
    end
