class DomainNameRegistry
  def initialize(domain_space)
    @domain_space = domain_space
    @registry = []
  end
  def buy_domain_name(domain_name)
    puts "Purchasing #{domain_name}.#{@domain_space}"
    sleep 2
    if (@registry.include?(domain_name))
      return PurchaseResult.new(false, "Not Available")
    end
    @registry << domain_name
    return PurchaseResult.new(true) 
  end
end

class PurchaseResult
  attr_reader :success
  attr_reader :message
  def initialize(success, message="")
    @success = success
    @message = message
  end
end

class ActivationQueue
  def initialize
    @mutex = Mutex.new
    @condition = ConditionVariable.new
    @items = []
  end
  def enqueue(item)
    @mutex.synchronize {
      @items << item
      @condition.signal
    }
  end
  def dequeue
    @mutex.synchronize {
        while @items.empty?
          @condition.wait(@mutex)
        end
        @items.shift
      }
  end
end

class Scheduler
  def initialize
    @activation_queue = ActivationQueue.new
    Thread.new {
      while true
        @activation_queue.dequeue.call
      end
     }
  end
  def enqueue(item)
    @activation_queue.enqueue(item)
  end
end

class DomainNameRegistryProxy
  def initialize(domain_space)
    @domain_name_registiry = DomainNameRegistry.new(domain_space)
    @scheduler = Scheduler.new
  end
  def buy_domain_name(domain_name)
    result = FutureResult.new
    @scheduler.enqueue lambda {
      result.value = @domain_name_registiry.buy_domain_name(domain_name)
     }
     return result
  end
end

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

com = DomainNameRegistryProxy.new("com")
com_au = DomainNameRegistryProxy.new("com.au")
co_nz = DomainNameRegistryProxy.new("co.nz")
com_result = com.buy_domain_name("foo")
com_au_result = com_au.buy_domain_name("foo")
co_nz_result = co_nz.buy_domain_name("foo")
puts com_result.success
puts com_au_result.success
puts co_nz_result.success
