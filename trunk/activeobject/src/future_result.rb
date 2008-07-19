class FutureResult
    def initialize
      @mutex = Mutex.new
      @condition = ConditionVariable.new
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
    def value=(result)
      @mutex.synchronize {
        @result = result;
        @condition.broadcast;
      }    
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
