package activeobject;


public class SynchronizedDomainNameRegistry {

	private final DomainNameRegistry domainNameRegistry;

	public SynchronizedDomainNameRegistry(String domainSpace) {
		domainNameRegistry = new DomainNameRegistry(domainSpace);
	}
	
	public synchronized PurchaseResult buyDomainName(String domainName)
	{
		return domainNameRegistry.buyDomainName(domainName);
	}
}
