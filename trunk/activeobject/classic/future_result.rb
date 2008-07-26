class FutureResult
    def initialize
      @mutex = Mutex.new
      @condition = ConditionVariable.new
    end

    def value=(result)
      @mutex.synchronize {
        @result = result;
        @condition.broadcast;
      }    
    end

    def full_domain_name
      wait_for_result
      return @result.full_domain_name
    end
    def success
      wait_for_result
      return @result.success
    end
    def message
      wait_for_result
      return @result.message
    end
    def to_s
      wait_for_result
      return @result.to_s
    end

    
  private
    def wait_for_result
      @mutex.synchronize {
        while ! @result
          @condition.wait(@mutex)
        end
      }
    end
end

# Can be generalized by using the following instead of defining
# individual methods for success, message, etc.  Still need to define to_s and any other
# methods defined on Object itself.
# 
#    def method_missing(method_name, *args)
#      wait_for_result
#      @result.send(method_name, *args)
#    end

