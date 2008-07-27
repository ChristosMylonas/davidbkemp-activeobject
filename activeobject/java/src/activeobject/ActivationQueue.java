package activeobject;

import java.util.ArrayDeque;
import java.util.Deque;

// In reality, we would use something like java.util.concurrent.ArrayBlockingQueue
public class ActivationQueue<T> {
	private Deque<T> items = new ArrayDeque<T>();
	
	public synchronized void enqueue(T item) {
		items.addLast(item);
		notifyAll();
	}
	
	public synchronized T dequeue() {
		while (items.isEmpty()) {
			waitForNotification();
		}
		return items.removeFirst();
	}

	private void waitForNotification() {
		try {
			wait();
		} catch (InterruptedException e) {
			throw new RuntimeException(e);
		}
	}
}
