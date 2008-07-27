package activeobject;


public class ActiveDomainNameRegistry {
	private DomainNameRegistry domainNameRegistry;
	private Scheduler scheduler;
	
	public ActiveDomainNameRegistry(String domainSpace) {
		domainNameRegistry = new DomainNameRegistry(domainSpace);
		scheduler = new Scheduler();
	}
	
	public PurchaseResult buyDomainName(final String domainName)
	{
		final FuturePurchaseResult futurePurchaseResult = new FuturePurchaseResult();
		scheduler.enqueue(new Runnable() {
			public void run() {
				futurePurchaseResult.setValue(domainNameRegistry.buyDomainName(domainName));
			}
		});
		return futurePurchaseResult;
	}
}
