require "classic/domain_name_registry"

class DomainNameReseller
  def initialize
    @com = DomainNameRegistry.new("com")
    @com_au = DomainNameRegistry.new("com.au")
    @co_nz = DomainNameRegistry.new("co.nz")
  end
  def buy_across_all_spaces(domain_name)
    com_result = @com.buy_domain_name(domain_name)
    com_au_result = @com_au.buy_domain_name(domain_name)
    co_nz_result = @co_nz.buy_domain_name(domain_name)
    puts com_result.to_s + ", " + com_au_result.to_s + ", " + co_nz_result.to_s
  end
end


domain_name_reseller = DomainNameReseller.new
domain_name_reseller.buy_across_all_spaces("foo")
