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
    return PurchaseResult.new(full_domain_name, true, "Purchased") 
  end
end

class PurchaseResult
  attr_reader :full_domain_name
  attr_reader :success
  attr_reader :message
  def initialize(full_domain_name, success, message)
    @full_domain_name = full_domain_name
    @success = success
    @message = message
  end
  def to_s
    return @full_domain_name + ": " + @message
  end
end
