class Scheduler
  def initialize(activation_queue, servant)
    Thread.new {
      while true
        @activation_queue.dequeue.call(servant)
      end
     }
  end
end
