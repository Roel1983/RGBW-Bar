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
		
		
		this.outputStream = new OutputStream() {
			int i = 1;
			private final OutputStream os = serialPort.getOutputStream(); 
			@Override
			public void write(int b) throws IOException {
//				synchronized (System.out) {
//					System.out.format("%s<%02X>%s", ANSI_BLUE, b & 0xff, ANSI_RESET);					
//				}
				i *= 31;
				if ((i % 3000) == 9) {
					b |= 1 << (i % 8);
				}
				os.write(b);
			}
		};
//		this.inputStream = new InputStream() {
//			private final InputStream is = serialPort.getInputStream();
//			@Override
//			public int read() throws IOException {
//				final int b = is.read();
//				//synchronized (System.out) {
//					System.out.format("%s<%02X>%s", ANSI_GREEN, b & 0xff, ANSI_RESET);
//				//}
//				return b;
//			}
//		};
//		this.outputStream = this.serialPort.getOutputStream();
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
