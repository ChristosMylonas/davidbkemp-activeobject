package examples;

import activeobject.PurchaseResult;
import activeobject.SynchronizedDomainNameRegistry;

public class MultiThreadedDomainNameSeller {

	private SynchronizedDomainNameRegistry com = new SynchronizedDomainNameRegistry("com");
	private SynchronizedDomainNameRegistry comAu = new SynchronizedDomainNameRegistry("com.au");
	private SynchronizedDomainNameRegistry coNz = new SynchronizedDomainNameRegistry("co.nz");
	private SynchronizedDomainNameRegistry coUk = new SynchronizedDomainNameRegistry("co.uk");
	
	public void byAccrossAllDomainSpaces(String domainName)
	{
		PurchaseResult comResult = com.buyDomainName(domainName);
		PurchaseResult comAuResult = comAu.buyDomainName(domainName);
		PurchaseResult coNzResult = coNz.buyDomainName(domainName);
		PurchaseResult coUkResult = coUk.buyDomainName(domainName);
		System.out.println("Results: " + comResult + ", " + comAuResult + ", " + coNzResult+  ", " + coUkResult);
	}
	
	public static void main(String[] args) throws InterruptedException {
		final MultiThreadedDomainNameSeller domainNameSeller = new MultiThreadedDomainNameSeller();
		Thread t1 = new Thread() {
			public void run() {
				domainNameSeller.byAccrossAllDomainSpaces("foo");
			}
		};
		t1.start();
		Thread t2 = new Thread() {
			public void run() {
				domainNameSeller.byAccrossAllDomainSpaces("foo");
			}
		};
		t2.start();
		t1.join();
		t2.join();
	}

}
