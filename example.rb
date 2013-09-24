require './safetyblanket'

module SafetyBlanket
  require 'set'
  
  def set(symbol)
    safetyblanketize symbol, Set
  end
  
  def PosInt(symbol)
    safetyblanketize symbol, Fixnum do |retval|
      retval > 0
    end
  end
  
  def Palindrome(symbol)
    safetyblanketize symbol, String do |str|
      str == str.reverse
    end
  end
end

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
  
  PosInt def bar(arg)
    puts arg
    arg
  end
  
  Palindrome def bands(index)
    band = ['ABBA', 'Ziggy Pop'][index]
    puts band
    band
  end
end

cruft = Cruft.new
cruft.foo 37
cruft.bands 0
cruft.null_factory "🏭"
cruft.first_letter "pie"
cruft.bar 20
cruft.foo "monkey"