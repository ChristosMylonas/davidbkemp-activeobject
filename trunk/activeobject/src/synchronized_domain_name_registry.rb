require "src/domain_name_registry"

class SynchronizedDomainNameRegistry
  def initialize(domain_space)
    @domain_name_registry = DomainNameRegistry.new(domain_space)
    @mutex = Mutex.new
  end
  def buy_domain_name(domain_name)
    @mutex.synchronize {
      @domain_name_registry.buy_domain_name(domain_name)
    }
  end
end