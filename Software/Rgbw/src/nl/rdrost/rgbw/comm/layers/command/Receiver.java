package nl.rdrost.rgbw.comm.layers.command;

import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.util.Objects;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingDeque;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.packet.Command;

public class Receiver implements Closeable {
	
	private final nl.rdrost.rgbw.comm.layers.packet.Receiver inner_receiver;
	
	private Thread thread;
	private final BlockingQueue<AbstractCommand> command_queue;
	
	public Receiver(final InputStream is) {
		this(new nl.rdrost.rgbw.comm.layers.packet.Receiver(is));
	}
	
	public Receiver(final nl.rdrost.rgbw.comm.layers.packet.Receiver inner_receiver) {
		this(inner_receiver, 100);
	}
	
	public Receiver(final nl.rdrost.rgbw.comm.layers.packet.Receiver inner_receiver, 
			final int capacity) {
		this(inner_receiver, new LinkedBlockingDeque<>(capacity));
	}
	
	public Receiver(final nl.rdrost.rgbw.comm.layers.packet.Receiver inner_receiver, 
			final BlockingQueue<AbstractCommand> command_queue) {
		Objects.nonNull(inner_receiver);
		Objects.nonNull(command_queue);
		
		this.inner_receiver = inner_receiver;
		this.command_queue  = command_queue;
		
		thread = new Thread(new MyRunable());
		thread.start();
	}
	
	public final BlockingQueue<AbstractCommand> getCommand_queue() {
		return this.command_queue;
	}
	
	@Override
	public void close() throws IOException {
		thread.interrupt();
		this.inner_receiver.close();
	}
	
	class MyRunable implements Runnable {

		@Override
		public void run() {
			final BlockingQueue<Command> commandQueue = inner_receiver.getCommandQueue();
			try {
				while (!Thread.interrupted()) {
					final Command layer1_command = commandQueue.take();
					
					final byte command_id_byte = layer1_command.getCommand_id();
					CommandId.fromValue(command_id_byte).ifPresent((CommandId command_id) -> {
						AbstractCommand command = command_id.info.commandFrom(layer1_command);
						try {
							command_queue.put(command);
						} catch (final InterruptedException e) {
							Thread.currentThread().interrupt();
						}
					});
				}
			} catch (final InterruptedException e) {
			}
		}
	}
}
