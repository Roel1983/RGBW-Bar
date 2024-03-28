package nl.rdrost.rgbw.comm.layers.packet;

import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Objects;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingDeque;


public class Receiver implements Closeable {
	
	enum Error {PREAMBLE, CRC};
	
	private final InputStream is;
	private final BlockingQueue<Command> command_queue;
	
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
		
		thread = new Thread(new MyRunable(), "comm-packet-receiver");
		thread.start();
	}
	
	public final InputStream getInputStream() {
		return this.is;
	}
	
	public final BlockingQueue<Command> getCommandQueue() {
		return this.command_queue;
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
		
		enum AnsiColor {
			RESET(0, 0),
			BLACK(30, 40),
			RED(31, 41),
			GREEN(32, 42),
			YELLOW(33, 43),
			BLUE(34, 44),
			MAGENTA(35, 45),
			CYAN(36, 46),
			WHITE(37, 47),
			BRIGHT_BLACK(90, 100),
			BRIGHT_RED(91, 101),
			BRIGHT_GREEN(92, 102),
			BRIGHT_YELLOW(93, 103),
			BRIGHT_BLUE(94, 104),
			BRIGHT_MAGENTA(95, 105),
			BRIGHT_CYAN(96, 106),
			BRIGHT_WHITE(97, 107),;
			
			public final String forground;
			public final String background;
			
			private AnsiColor(final int fg, final int bg) {
				this.forground  = String.format("\u001B[%dm", fg);
				this.background = String.format("\u001B[%dm", bg);
			}
		}
		
		enum State {
			PREAMBLE(AnsiColor.BLACK),
			SENDER_UNIQUE_ID(AnsiColor.RED),
			COMMAND_ID(AnsiColor.YELLOW),
			BODY_LENGTH(AnsiColor.BLUE),
			CRC(AnsiColor.CYAN, true);
			
			private State(final AnsiColor color) {
				this(color, false);
			}
			
			private State(final AnsiColor color, boolean newline) {
				this.color = color;
				if(newline) {
					this.formater = String.format("%s<%%02X>%s%n", color.forground, AnsiColor.RESET.forground);
				} else {
					this.formater = String.format("%s<%%02X>%s", color.forground, AnsiColor.RESET.forground);
				}
			}
			
			public final AnsiColor color;
			public final String formater;
		}
		
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
			
			if (receiveBody(data_byte)) {
				System.out.print(String.format("%s<%02X>%s",AnsiColor.BRIGHT_MAGENTA.forground, data_byte, AnsiColor.RESET.forground));
				return;
			}
			System.out.print(String.format(state.formater, data_byte));
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
			case CRC:
				receiveCrc(data_byte);
				return;
			}			
		}
		
		private boolean receiveBody(byte data_byte) {
			if (body == null || body.remaining() == 0) {
				return false;
			}
			body.put(data_byte);
			return true;
		}
		
		static boolean preamble_error_raised = false;
		private void receivePreamble(byte data_byte) {
			if (data_byte != PREAMBLE_BYTE) {
				if (!preamble_error_raised) {
					fireOnError(Error.PREAMBLE);
					preamble_error_raised = true;
				}
				preamble_count = 0;
				return;
			}
			if (++preamble_count >= PREAMBLE_COUNT) {
				preamble_error_raised = false;
				crc            = 0;
				preamble_count = 0;
				state          = State.SENDER_UNIQUE_ID;
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
			state = State.CRC;
		}
		
		private void receiveCrc(byte data_byte) {
			if (this.crc != 0x00) {
				fireOnError(Error.CRC);
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
			this.body = null;
			state = State.PREAMBLE;
		}
	}
}
