package nl.rdrost.rgbw.comm.layers.packet;

import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Objects;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingDeque;

import nl.rdrost.rgbw.util.AnsiColor;


public class Receiver implements Closeable {
	
	enum State {
		PREAMBLE(AnsiColor.BLACK),
		SENDER_UNIQUE_ID(AnsiColor.RED),
		COMMAND_ID(AnsiColor.YELLOW),
		BODY_LENGTH(AnsiColor.BLUE),
		BODY(AnsiColor.BRIGHT_MAGENTA),
		CRC(AnsiColor.CYAN, true);
		
		private State(final AnsiColor color) {
			this(color, false);
		}
		
		private State(final AnsiColor color, boolean newline) {
			this.color = color;
			if(newline) {
				this.formater         = String.format("[%%02X]%n");
				this.formater_colored = String.format("%s[%%02X]%s%n", color.forground, AnsiColor.RESET.forground);
			} else {
				this.formater         = "[%02X]";
				this.formater_colored = String.format("%s[%%02X]%s", color.forground, AnsiColor.RESET.forground);
			}
		}
		
		public final AnsiColor color;
		public final String formater;
		public final String formater_colored;
	}
	
	enum Error      {PREAMBLE, CRC};
	enum DebugPrint {
		OFF {
			@Override
			void print(State state, byte data_byte) {
			}
		}, ON {
			@Override void print(State state, byte data_byte) {
				System.out.print(String.format(state.formater, data_byte));
			}
		}, ON_COLORED {
			@Override void print(State state, byte data_byte) {
				System.out.print(String.format(state.formater_colored, data_byte));
			}
		} ;

		abstract void print(State state, byte data_byte);
		
	};
	
	private final InputStream is;
	private final BlockingQueue<Command> command_queue;
	private volatile DebugPrint debug_print = DebugPrint.OFF;
	
	private Thread thread;
	
	public Receiver(final InputStream is) {
		this(is, 100);
	}
	
	public Receiver(final InputStream is, final int capacity) {
		this(is, new LinkedBlockingDeque<>(capacity));
	}
	
	public Receiver(final InputStream is, final BlockingQueue<Command> command_queue) {
		Objects.nonNull(is);
		Objects.nonNull(command_queue);
		
		this.is = is;
		this.command_queue = command_queue;
		
		thread = new Thread(new MyRunable());
		thread.start();
	}
	
	public final InputStream getInputStream() {
		return this.is;
	}
	
	public final BlockingQueue<Command> getCommandQueue() {
		return this.command_queue;
	}
	
	public final void setDebugPrint(final DebugPrint value) {
		this.debug_print = value;
	}
	
	public final DebugPrint getDebugPrint() {
		return this.debug_print;
	}
	
	@Override
	public void close() throws IOException {
		this.thread.interrupt();
	}
	
	private void fireOnError(final Error error) {
		System.err.println("layer1.Receiver.fireOnError: " + error);
		// TODO
	}
	
	private class MyRunable implements Runnable {
		
		private static final byte PREAMBLE_BYTE  = 0x55;
		private static final byte PREAMBLE_COUNT = 2;
		private static final byte EXTENDED_PAYLOAD_LENGHT_MASK = (byte)0x80;
		
		private State state = State.PREAMBLE;
		
		private byte crc              = 0;
		private int preamble_count    = 0;
		private byte sender_unique_id = 0;
		private byte command_id;
		private int remaining_payload_length;
		private ByteBuffer body       = null;
		
		public void run() {
			while (!Thread.interrupted()) {
				try {
					byte data_byte = (byte) is.read();
					processIncommingByte(data_byte);
				} catch (java.io.InterruptedIOException e) {
				} catch (IOException e) {
					System.err.print('!');
					Thread.currentThread().interrupt();
				}
			}
		}
		
		private void processIncommingByte(final byte data_byte) {
			crc += data_byte;
			
			debug_print.print(state, data_byte);
			switch (state) {
			case PREAMBLE:
				receivePreamble(data_byte);
				return;
			case SENDER_UNIQUE_ID:
				receiveSenderUniqueId(data_byte);
				return;
			case COMMAND_ID:
				receiveCommandId(data_byte);
				return;
			case BODY_LENGTH:
				receiveBodyLength(data_byte);
				return;
			case BODY:
				receiveBody(data_byte);
				return;
			case CRC:
				receiveCrc(data_byte);
				return;
			}			
		}
		
		private void receiveBody(byte data_byte) {
			body.put(data_byte);
			if (body.remaining() == 0) {
				state = State.CRC;
			}
		}

		private void receivePreamble(byte data_byte) {
			if (data_byte != PREAMBLE_BYTE) {
				fireOnError(Error.PREAMBLE);
				preamble_count = 0;
				state          = State.PREAMBLE;
				return;
			}
			if (++preamble_count >= PREAMBLE_COUNT) {
				crc   = 0;
				state = State.SENDER_UNIQUE_ID;
			}
		}

		private void receiveSenderUniqueId(byte data_byte) {
			sender_unique_id = data_byte;
			state = State.COMMAND_ID;
		}

		private void receiveCommandId(byte data_byte) {
			command_id = data_byte;
			remaining_payload_length = 0;
			state      = State.BODY_LENGTH;
		}

		private void receiveBodyLength(byte data_byte) {
			// TODO test this
			if ((data_byte & EXTENDED_PAYLOAD_LENGHT_MASK) != 0) {
				remaining_payload_length = (data_byte & ~EXTENDED_PAYLOAD_LENGHT_MASK) << 8;
				return;
			} else {
				remaining_payload_length |= data_byte;
			}
			body = ByteBuffer.allocate(remaining_payload_length).order(ByteOrder.LITTLE_ENDIAN);
			state = State.BODY;
		}
		
		private void receiveCrc(byte data_byte) {
			if (this.crc != 0x00) {
				fireOnError(Error.CRC);
				preamble_count = 0;
				state = State.PREAMBLE;
				return;
			}
			Command command = new Command(
					this.sender_unique_id,
					this.command_id,
					this.body.flip());
			try {
				command_queue.put(command);
			} catch (final InterruptedException e) {
				Thread.currentThread().interrupt();
			}
			preamble_count = 0;
			state = State.PREAMBLE;
		}
	}
}
