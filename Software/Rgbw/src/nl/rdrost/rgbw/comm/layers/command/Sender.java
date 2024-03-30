package nl.rdrost.rgbw.comm.layers.command;

import java.io.Closeable;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;

public class Sender implements Closeable {
	
	private final nl.rdrost.rgbw.comm.layers.packet.Sender inner_sender;
	
	public Sender(final OutputStream os) {
		inner_sender = new nl.rdrost.rgbw.comm.layers.packet.Sender(os);
	}
	
	public final OutputStream getOutputStream() {
		return inner_sender.getOutputStream();
	}
	
	public void send(final AbstractCommand command) throws IOException {
		Objects.nonNull(command);
		
		inner_sender.send(command.getPacketCommand());
	}
	
	public void flush() throws IOException {
		inner_sender.flush();
	}

	@Override
	public void close() throws IOException {
		inner_sender.close();
	}
}
