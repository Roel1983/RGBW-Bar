package nl.rdrost.rgbw.comm.layer2;

import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.util.Objects;
import java.util.Optional;
import java.util.concurrent.BlockingQueue;

import nl.rdrost.rgbw.comm.layer1.Command;

public class Receiver implements Closeable {
	
	private final nl.rdrost.rgbw.comm.layer1.Receiver inner_receiver;
	
	private Thread thread;
	
	public Receiver(final InputStream is) {
		this(new nl.rdrost.rgbw.comm.layer1.Receiver(is));
	}
	
	public Receiver(final nl.rdrost.rgbw.comm.layer1.Receiver inner_receiver) {
		Objects.nonNull(inner_receiver);
		
		this.inner_receiver = inner_receiver;
		
		thread = new Thread(new MyRunable());
		thread.start();
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
					System.out.print(layer1_command);
					
					final byte command_id_byte = layer1_command.getCommand_id();
					CommandId.fromValue(command_id_byte).ifPresent((CommandId command_id) -> {
						AbstractCommand command = command_id.info.commandFrom(layer1_command);
						System.out.print(layer1_command);
					});
				}
			} catch (final InterruptedException e) {
			}
		}
	}
}
