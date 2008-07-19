require "src/activation_queue"

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
# Could be made more flexible by having the target "servent" object injected and passing
# the servent as a parameter to invocation of "call".  This would allow multiple servents
# per activation queue (e.g. a domain name registry allowing more than one but still limited number of connections.)