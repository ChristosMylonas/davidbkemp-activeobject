require "variation/activation_queue"
require "variation/active_object"
require "variation/scheduler"
require "variation/domain_name_registry"

class DomainNameReseller
  def initialize
    com_servant1 = DomainNameRegistry.new("com")
    com_servant2 = DomainNameRegistry.new("com")
    com_au_servant = DomainNameRegistry.new("com.au")
    co_nz_servant = DomainNameRegistry.new("co.nz")
    co_uk_servant = DomainNameRegistry.new("co.uk")

    com_queue = ActivationQueue.new 
    com_au_queue = ActivationQueue.new 
    co_nz_queue = ActivationQueue.new
    co_uk_queue = ActivationQueue.new
    
    com_scheduler1 = Scheduler.new(com_queue, com_servant1)
    com_scheduler2 = Scheduler.new(com_queue, com_servant2)
    com_au_scheduler = Scheduler.new(com_au_queue, com_au_servant)
    co_nz_scheduler = Scheduler.new(co_nz_queue, co_nz_servant)
    co_uk_scheduler = Scheduler.new(co_uk_queue, co_uk_servant)
    
    @com = ActiveObject.new(com_queue)
    @com_au = ActiveObject.new(com_au_queue)
    @co_nz = ActiveObject.new(co_nz_queue)
    @co_uk = ActiveObject.new(co_uk_queue)
  end
  def buy_across_all_spaces(client_name, domain_name)
    com_result = @com.buy_domain_name(domain_name)
    com_au_result = @com_au.buy_domain_name(domain_name)
    co_nz_result = @co_nz.buy_domain_name(domain_name)
    co_uk_result = @co_uk.buy_domain_name(domain_name)
    puts "#{client_name}: #{com_result}, #{com_au_result}, #{co_nz_result}, #{co_uk_result}"
  end
end


domain_name_reseller = DomainNameReseller.new
start = Time.now
thread1 = Thread.new {domain_name_reseller.buy_across_all_spaces("A", "foo")}
thread2 = Thread.new {domain_name_reseller.buy_across_all_spaces("B", "bar")}
thread1.join
thread2.join
puts Time.now - start