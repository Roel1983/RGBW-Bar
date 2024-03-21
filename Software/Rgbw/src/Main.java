import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.Duration;
import java.util.Arrays;

import com.fazecast.jSerialComm.SerialPort;

import nl.rdrost.rgbw.comm.layer2.Receiver;
import nl.rdrost.rgbw.comm.layer2.Sender;
import nl.rdrost.rgbw.comm.layer3.LightControlModesCommand;
import nl.rdrost.rgbw.comm.layer3.RequestToSendCommand;
import nl.rdrost.rgbw.comm.layer3.StrobeTriggerCommand;
import nl.rdrost.rgbw.types.LightControlModes;

public class Main {
	public static final String ANSI_RESET = "\u001B[0m";
	public static final String ANSI_GREEN = "\u001B[32m";
	public static final String ANSI_BLUE  = "\u001B[34m";

	
	public static void main(String[] args) throws IOException, InterruptedException {
		SerialPort[] comPorts = SerialPort.getCommPorts();
		Arrays.stream(comPorts)
				.map(s -> s.getSystemPortPath())
				.forEach(str -> System.out.println(str));
		
		SerialPort comPort = comPorts[2];
		comPort.openPort();
		comPort.setBaudRate(115200);
		comPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_SEMI_BLOCKING, 1000, 1000);
		
		OutputStream os = new OutputStream() {
			private final OutputStream os = comPort.getOutputStream(); 
			@Override
			public void write(int b) throws IOException {
				System.out.print(ANSI_BLUE);
				System.out.format("<%02X>", b & 0xff);
				os.write(b);
				System.out.print(ANSI_GREEN);
			}
		};
		InputStream is = new InputStream() {
			private final InputStream is = comPort.getInputStream();
			@Override
			public int read() throws IOException {
				final int b = is.read();
				System.out.print(ANSI_GREEN);
				System.out.format("<%02X>", b & 0xff);
				System.out.print(ANSI_GREEN);
				return b;
			}
		};
		
		Receiver receiver = new Receiver(is);
		Sender sender = new Sender(os);
		
		sender.send(new LightControlModesCommand(new LightControlModes(LightControlModes.Value.ON, LightControlModes.Value.ON, LightControlModes.Value.OFF)));
		Thread.sleep(1000);
		//
		sender.send(new RequestToSendCommand(6, 8));
		Thread.sleep(1);
		sender.send(new StrobeTriggerCommand(Duration.ofMillis(10), Duration.ofMillis(10), 10));
		Thread.sleep(1000);
	}	
}