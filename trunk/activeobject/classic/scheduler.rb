require "classic/activation_queue"

class Scheduler
  def initialize
    @activation_queue = ActivationQueue.new
    Thread.new {
      while true
        @activation_queue.dequeue.call
      end
     }
  end
  def enqueue(&item)
    @activation_queue.enqueue(item)
  end
end

# Could be made more general by having the activiation queue injected into it.
# Could be made more flexible by having the target "servant" object injected and passing
# the servant as a parameter to invocation of "call".  This would allow multiple servants
# per activation queue (e.g. a domain name registry allowing more than one but still limited number of connections.)