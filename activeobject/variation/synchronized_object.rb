class SynchronizedObject
    def initialize(target)
      @mutex = Mutex.new
      @target = target
    end
    def method_missing(method_name, *args)
      @mutex.synchronize {
        @target.send(method_name, *args)
      }
    end
end


