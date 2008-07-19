require "src/domain_name_registry_proxy"

class DomainNameReseller
  def initialize
    @com = DomainNameRegistryProxy.new("com")
    @com_au = DomainNameRegistryProxy.new("com.au")
    @co_nz = DomainNameRegistryProxy.new("co.nz")
  end
  def buy_across_all_spaces(client_name, domain_name)
    com_result = @com.buy_domain_name(domain_name)
    com_au_result = @com_au.buy_domain_name(domain_name)
    co_nz_result = @co_nz.buy_domain_name(domain_name)
    puts client_name + ": " + com_result.to_s + ", " + com_au_result.to_s + ", " + co_nz_result.to_s
  end
end


domain_name_reseller = DomainNameReseller.new
client1 = Thread.new {domain_name_reseller.buy_across_all_spaces("A", "foo")}
client2 = Thread.new {domain_name_reseller.buy_across_all_spaces("B", "foo")}
client1.join
client2.join