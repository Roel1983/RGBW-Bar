package nl.rdrost.rgbw.comm.layers.bytes;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Objects;

//import com.fazecast.jSerialComm.SerialPort;
import jssc.SerialPort;
import jssc.SerialPortException;

public class ByteCommunication {
	
	public static final String ANSI_RESET = "\u001B[0m";
	public static final String ANSI_GREEN = "\u001B[32m";
	public static final String ANSI_BLUE  = "\u001B[34m";

	private final SerialPort  serialPort;
	private final InputStream  inputStream;
	private final OutputStream outputStream;
	
	public ByteCommunication(final String comPort) {
		this(new SerialPort(comPort));
	}
	
	public ByteCommunication(final SerialPort serialPort) {
		Objects.nonNull(serialPort);
		
		this.serialPort = serialPort;
		try {
			this.serialPort.openPort();//Open serial port
			this.serialPort.setParams(SerialPort.BAUDRATE_57600, 
			                     SerialPort.DATABITS_8,
			                     SerialPort.STOPBITS_1,
			                     SerialPort.PARITY_NONE);
		} catch (SerialPortException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		//Set params. Also you can set params by this string: serialPort.setParams(9600, 8, 1, 0);
//        serialPort.writeBytes("This is a test string".getBytes());//Write data to port
//        serialPort.closePort();//Close serial port
//		
//		this.serialPort = serialPort;
//		this.serialPort.openPort();
//		this.serialPort.setBaudRate(57600);
//		this.serialPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_SEMI_BLOCKING, 1000, 1000);
		
		
		this.outputStream = new OutputStream() {
			@Override
			public void write(int b) throws IOException {
				try {
					serialPort.writeByte((byte)b);
				} catch (SerialPortException e) {
					throw new IOException(e);
				}
			}
		};
		this.inputStream = new InputStream() {
			@Override
			public int read() throws IOException {
				try {
					return serialPort.readBytes(1)[0];
				} catch (SerialPortException e) {
					throw new IOException(e);
				}
			}
		};
	}

//	private static SerialPort findCommPort(final String serialPort) {
//		return SerialPort.getCommPort(serialPort);
//	}
	
	public final InputStream getInputStream() {
		return this.inputStream;
	}
	
	public final OutputStream getOutputStream() {
		return this.outputStream;
	}
}
