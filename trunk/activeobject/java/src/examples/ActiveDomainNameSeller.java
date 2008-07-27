package examples;

import activeobject.PurchaseResult;
import activeobject.ActiveDomainNameRegistry;

public class ActiveDomainNameSeller {

	private ActiveDomainNameRegistry com = new ActiveDomainNameRegistry("com");
	private ActiveDomainNameRegistry comAu = new ActiveDomainNameRegistry("com.au");
	private ActiveDomainNameRegistry coNz = new ActiveDomainNameRegistry("co.nz");
	private ActiveDomainNameRegistry coUk = new ActiveDomainNameRegistry("co.uk");
	
	public void byAccrossAllDomainSpaces(String domainName)
	{
		PurchaseResult comResult = com.buyDomainName(domainName);
		PurchaseResult comAuResult = comAu.buyDomainName(domainName);
		PurchaseResult coNzResult = coNz.buyDomainName(domainName);
		PurchaseResult coUkResult = coUk.buyDomainName(domainName);
		System.out.println("Results: " + comResult + ", " + comAuResult + ", " + coNzResult+  ", " + coUkResult);
	}
	
	public static void main(String[] args) throws InterruptedException {
		final ActiveDomainNameSeller domainNameSeller = new ActiveDomainNameSeller();
		Thread t1 = new Thread() {
			public void run() {
				domainNameSeller.byAccrossAllDomainSpaces("foo");
			}
		};
		Thread t2 = new Thread() {
			public void run() {
				domainNameSeller.byAccrossAllDomainSpaces("bar");
			}
		};
		long startTime = System.currentTimeMillis();
		t1.start();
		t2.start();
		t1.join();
		t2.join();
		System.out.println((System.currentTimeMillis() - startTime)/1000);
	}

}
