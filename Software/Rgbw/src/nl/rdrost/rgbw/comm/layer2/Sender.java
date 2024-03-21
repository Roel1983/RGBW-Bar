package nl.rdrost.rgbw.comm.layer2;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Objects;

public class Sender {
	
	private final nl.rdrost.rgbw.comm.layer1.Sender inner_sender;
	
	public Sender(final OutputStream os) {
		inner_sender = new nl.rdrost.rgbw.comm.layer1.Sender(os);
	}
	
	public final OutputStream getOutputStream() {
		return inner_sender.getOutputStream();
	}
	
	public void send(final AbstractCommand command) throws IOException {
		Objects.nonNull(command);
		inner_sender.send(command.asCommand());
	}
}

