package nl.rdrost.rgbw.comm.layers.packet;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.ByteBuffer;
import java.util.Objects;

public class Sender {
	private final OutputStream os;
	
	public Sender(final OutputStream os) {
		Objects.nonNull(os);
		this.os = os;
	}
	
	public final OutputStream getOutputStream() {
		return this.os;
	}
	
	public void send(final Command command) throws IOException {
		Objects.nonNull(command);
		
		ByteBuffer body = command.body.duplicate();
		os.write(0x55);
		os.write(0x55);
		os.write(command.sender_unique_id);
		os.write(command.command_id);
		int payload_length = body.remaining();
		
		byte crc = (byte)(0 - command.sender_unique_id - command.command_id);
		
		if (payload_length > 0x7F) {
			byte b1 = (byte)((payload_length >> 8) | 0x80);
			byte b2 = (byte)(payload_length & 0xFF); 
			os.write(b1);
			os.write(b2);
			
			crc -= (b1 + b2);
			
		} else {
			os.write(payload_length);
			crc -= payload_length;
		}
				
		while (body.hasRemaining()) {
			byte b = body.get();
			os.write(b);
			crc -= b;
		}	
		os.write(crc);		
	}

	public void flush() throws IOException {
		os.flush();
	}
}
