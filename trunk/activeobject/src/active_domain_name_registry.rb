require "src/domain_name_registry"
require "src/scheduler"
require "src/future_result"

class ActiveDomainNameRegistry
  def initialize(domain_space)
    @domain_name_registiry = DomainNameRegistry.new(domain_space)
    @scheduler = Scheduler.new
  end
  def buy_domain_name(domain_name)
    result = FutureResult.new
    @scheduler.enqueue {
      result.value = @domain_name_registiry.buy_domain_name(domain_name)
    }
    return result
  end
end