module SafetyBlanket
  def safetyblanketize(symbol, type)
    original_method = "_unsafe_#{symbol}"

    class_eval %Q{
      raise "Already safetyblanketed #{symbol}" if method_defined?(:#{original_method})
      alias #{original_method} #{symbol}

      def #{symbol}(*args)
        retval = #{original_method}(*args)
        return retval unless !retval.is_a? #{type.name}
        raise RuntimeError, "#{symbol} returned #{'#{retval.class}'} instead of #{type}"
      end
    }
  end
  
  def int(symbol)
    safetyblanketize symbol, Fixnum
  end
  
  def string(symbol)
    safetyblanketize symbol, String
  end
  
  def float(symbol)
    safetyblanketize symbol, Float
  end
end




