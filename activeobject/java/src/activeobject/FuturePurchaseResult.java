package activeobject;

// In reality, you should consider wrapping something like java.util.Future and/or take advantage of
// ExecutorService.submit() returning a Future.
public class FuturePurchaseResult implements PurchaseResult {

	private PurchaseResult result;

	public synchronized void setValue(PurchaseResult result) {
		this.result = result;
		notifyAll();
	}

	public String getFullDomainName() {
		waitForResult();
		return result.getFullDomainName();
	}

	public String getMessage() {
		waitForResult();
		return result.getMessage();
	}

	public boolean isSuccess() {
		waitForResult();
		return result.isSuccess();
	}

	public String toString() {
		waitForResult();
		return result.toString();
	}

	private void waitForResult() {
		while(result == null) {
			waitForNotification();
		}
	}

	private synchronized void waitForNotification() {
		try {
			wait();
		} catch (InterruptedException e) {
			throw new RuntimeException(e);
		}
	}

}
