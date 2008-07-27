package examples;

import activeobject.DomainNameRegistry;
import activeobject.PurchaseResult;

public class ThreadlessDomainNameSeller {

	private DomainNameRegistry com = new DomainNameRegistry("com");
	private DomainNameRegistry comAu = new DomainNameRegistry("com.au");
	private DomainNameRegistry coNz = new DomainNameRegistry("co.nz");
	
	public void byAccrossAllDomainSpaces(String domainName)
	{
		PurchaseResult comResult = com.buyDomainName(domainName);
		PurchaseResult comAuResult = comAu.buyDomainName(domainName);
		PurchaseResult coNzResult = coNz.buyDomainName(domainName);
		System.out.println("Results: " + comResult + ", " + comAuResult + ", " + coNzResult);
	}
	
	public static void main(String[] args) {
		ThreadlessDomainNameSeller domainNameSeller = new ThreadlessDomainNameSeller();
		domainNameSeller.byAccrossAllDomainSpaces("foo");
	}

}
