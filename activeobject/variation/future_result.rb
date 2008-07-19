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
    def method_missing(method_name, *args)
      wait_for_result
      @result.send(method_name, *args)
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


