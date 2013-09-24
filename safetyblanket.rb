module SafetyBlanket
  def safetyblanketize(symbol, type=nil, &block)
    original_method = "_unsafe_#{symbol}"
    
    type_check = %Q{
      if not retval.is_a? #{type.name}
        raise RuntimeError, "#{symbol} returned #{'#{retval.class}'} instead of #{type}"
      end
    }
    
    block_check = if block_given?
      class_variable_set '@@_safety_checks', {} if not class_variable_defined? '@@_safety_checks' 
      class_variable_get('@@_safety_checks')[symbol] = block
      %Q{
        safety_check = @@_safety_checks[:#{symbol}]
        if not safety_check.call(retval)
          raise RuntimeError, "#{symbol} fails return value test at #{'#{safety_check.source_location.first}'}:#{'#{safety_check.source_location.last}'}"
        end
      }
    end   

    class_eval %Q{
      raise "Already safetyblanketed #{symbol}" if method_defined?(:#{original_method})
      alias #{original_method} #{symbol}
      
      def #{symbol}(*args)
        retval = #{original_method}(*args)
        
        #{type_check}
        #{block_check}
        
        retval
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
  
  def char(symbol)
    safetyblanketize symbol, String do |str|
      str.length == 1
    end
  end
end




