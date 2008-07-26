require "classic/synchronized_domain_name_registry"

class DomainNameReseller
  def initialize
    @com = SynchronizedDomainNameRegistry.new("com")
    @com_au = SynchronizedDomainNameRegistry.new("com.au")
    @co_nz = SynchronizedDomainNameRegistry.new("co.nz")
    @co_uk = SynchronizedDomainNameRegistry.new("co.uk")
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
thread1 = Thread.new {
  domain_name_reseller.buy_across_all_spaces("A", "foo")
}
thread2 = Thread.new {
  domain_name_reseller.buy_across_all_spaces("B", "foo")
}
thread1.join
thread2.join
puts Time.now - start