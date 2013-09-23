require './safetyblanket'

module SafetyBlanket
  require 'set'
  
  def set(symbol)
    safetyblanketize symbol, Set
  end
end

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