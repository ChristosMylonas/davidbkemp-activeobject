package activeobject;

public class Scheduler {
	private ActivationQueue<Runnable> activationQueue = new ActivationQueue<Runnable>();

	public Scheduler() {
		Thread thread = new Thread() {
			public void run() {
				while (true) {
					activationQueue.dequeue().run();
				}
			}
		};
		thread.start();
	}

	public void enqueue(Runnable runnable) {
		activationQueue.enqueue(runnable);
	}

}
