package activeobject;

import java.util.HashSet;
import java.util.Set;

public class DomainNameRegistry {

	private final String domainSpace;
	private Set<String> registry = new HashSet<String>();

	public DomainNameRegistry(String domainSpace) {
		this.domainSpace = domainSpace;
	}
	
	public PurchaseResult buyDomainName(String domainName)
	{
		// Pretend remote call takes 2 seconds.
		sleep(2);
		if (registry.contains(domainName)) {
			return new SimplePurchaseResult(fullDomainName(domainName), false, "Not Available");
		}
		registry.add(domainName);
		return new SimplePurchaseResult(fullDomainName(domainName), true, "Purchased");
	}

	private String fullDomainName(String domainName) {
		return domainName + "." + domainSpace;
	}

	private void sleep(int secs) {
		try {
			Thread.sleep(secs * 1000);
		} catch (InterruptedException e) {
			throw new RuntimeException(e);
		}
	}
}
