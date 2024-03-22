package nl.rdrost.rgbw.comm.layers.bytes;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Objects;

import com.fazecast.jSerialComm.SerialPort;

public class ByteCommunication {
	
	public static final String ANSI_RESET = "\u001B[0m";
	public static final String ANSI_GREEN = "\u001B[32m";
	public static final String ANSI_BLUE  = "\u001B[34m";

	private final SerialPort  serialPort;
	private final InputStream  inputStream;
	private final OutputStream outputStream;
	
	public ByteCommunication(final String comPort) {
		this(findCommPort(comPort));
	}
	
	public ByteCommunication(final SerialPort serialPort) {
		Objects.nonNull(serialPort);
		
		this.serialPort = serialPort;
		this.serialPort.openPort();
		this.serialPort.setBaudRate(115200);
		this.serialPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_SEMI_BLOCKING, 1000, 1000);
		
		
//		this.outputStream = new OutputStream() {
//			private final OutputStream os = serialPort.getOutputStream(); 
//			@Override
//			public void write(int b) throws IOException {
//				System.out.print(ANSI_BLUE);
//				System.out.format("<%02X>", b & 0xff);
//				os.write(b);
//				System.out.print(ANSI_GREEN);
//			}
//		};
//		this.inputStream = new InputStream() {
//			private final InputStream is = serialPort.getInputStream();
//			@Override
//			public int read() throws IOException {
//				final int b = is.read();
//				System.out.print(ANSI_GREEN);
//				System.out.format("<%02X>", b & 0xff);
//				System.out.print(ANSI_GREEN);
//				return b;
//			}
//		};
		this.outputStream = this.serialPort.getOutputStream();
		this.inputStream  = this.serialPort.getInputStream();
	}

	private static SerialPort findCommPort(final String serialPort) {
		return SerialPort.getCommPort(serialPort);
	}
	
	public final InputStream getInputStream() {
		return this.inputStream;
	}
	
	public final OutputStream getOutputStream() {
		return this.outputStream;
	}
}
