require "src/domain_name_registry_proxy"

com = DomainNameRegistryProxy.new("com")
com_au = DomainNameRegistryProxy.new("com.au")
co_nz = DomainNameRegistryProxy.new("co.nz")
com_result = com.buy_domain_name("foo")
com_au_result = com_au.buy_domain_name("foo")
co_nz_result = co_nz.buy_domain_name("foo")
puts com_result.to_s + ", " + com_au_result.to_s + ", " + co_nz_result.to_s
puts com.buy_domain_name("foo").to_s