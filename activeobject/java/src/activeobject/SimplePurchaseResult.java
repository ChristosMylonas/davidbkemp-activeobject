package activeobject;

public class SimplePurchaseResult implements PurchaseResult
{
	private final String fullDomainName;
	private final boolean success;
	private final String message;

	public SimplePurchaseResult(String fullDomainName, boolean success, String message) {
		this.fullDomainName = fullDomainName;
		this.success = success;
		this.message = message;
	}

	public String getFullDomainName() {
		return fullDomainName;
	}

	public boolean isSuccess() {
		return success;
	}

	public String getMessage() {
		return message;
	}
	
	@Override
	public String toString() {
		return fullDomainName + ": " + success; 
	}
}