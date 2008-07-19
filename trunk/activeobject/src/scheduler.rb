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