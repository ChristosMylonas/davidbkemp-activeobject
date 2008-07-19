class ActivationQueue
  def initialize
    @mutex = Mutex.new
    @condition = ConditionVariable.new
    @items = []
  end
  def enqueue(&block)
    @mutex.synchronize {
      @items << block
      @condition.signal
    }
  end
  def dequeue
    @mutex.synchronize {
        while @items.empty?
          @condition.wait(@mutex)
        end
        return @items.shift
      }
  end
end
