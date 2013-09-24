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
      true
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
  
  PosInt def bar(arg)
    puts arg
    arg
  end
end

cruft = Cruft.new
cruft.foo 37
cruft.foo 23
cruft.first_letter "pie"
cruft.bar -20
cruft.foo "monkey"