class DomainNameRegistry
  def initialize(domain_space)
    @domain_space = domain_space
    @registry = []
  end
  def buy_domain_name(domain_name)
    full_domain_name = "#{domain_name}.#{@domain_space}"
    sleep 2
    if (@registry.include?(domain_name))
      return PurchaseResult.new(full_domain_name, false, "Not Available")
    end
    @registry << domain_name
    return PurchaseResult.new(full_domain_name, true) 
  end
end

class PurchaseResult
  attr_reader :full_domain_name
  attr_reader :success
  attr_reader :message
  def initialize(full_domain_name, success, message="")
    @full_domain_name = full_domain_name
    @success = success
    @message = message
  end
  def to_s
    return @full_domain_name + ": " + (@success ? "Purchased" : @message)
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

com = DomainNameRegistryProxy.new("com")
com_au = DomainNameRegistryProxy.new("com.au")
co_nz = DomainNameRegistryProxy.new("co.nz")
com_result = com.buy_domain_name("foo")
com_au_result = com_au.buy_domain_name("foo")
co_nz_result = co_nz.buy_domain_name("foo")
puts com_result.to_s + ", " + com_au_result.to_s + ", " + co_nz_result.to_s
puts com.buy_domain_name("foo").to_s