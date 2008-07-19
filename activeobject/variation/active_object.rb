require "variation/future_result"

class ActiveObject
  def initialize(activation_queue)
    @activation_queue = activation_queue
  end
  def method_missing(method_name, *args)
    result = FutureResult.new
    @activation_queue.enqueue {
      |servant| result.value = servant.send(method_name, *args) 
    }
    return result
  end
end
