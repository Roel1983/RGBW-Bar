import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.Duration;
import java.util.Arrays;

import com.fazecast.jSerialComm.SerialPort;

import nl.rdrost.rgbw.comm.layers.bytes.ByteCommunication;
import nl.rdrost.rgbw.comm.layers.command.LightControlModesCommand;
import nl.rdrost.rgbw.comm.layers.command.Receiver;
import nl.rdrost.rgbw.comm.layers.command.RequestToSendCommand;
import nl.rdrost.rgbw.comm.layers.command.Sender;
import nl.rdrost.rgbw.comm.layers.command.SettingsReadCommand;
import nl.rdrost.rgbw.comm.layers.command.StrobeTriggerCommand;
import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.types.LightControlModes;

public class Main {
	public static final String ANSI_RESET = "\u001B[0m";
	public static final String ANSI_GREEN = "\u001B[32m";
	public static final String ANSI_BLUE  = "\u001B[34m";

	
	public static void main(String[] args) throws IOException, InterruptedException {

		ByteCommunication receiverSender = new ByteCommunication("/dev/ttyUSB0");
		Receiver receiver = new Receiver(receiverSender.getInputStream());
		Sender sender = new Sender(receiverSender.getOutputStream());
		
		Thread receiver_thread = new Thread(new Runnable() {
			
			@Override
			public void run() {
				while(!Thread.interrupted()) {
					try {
						final AbstractCommand command = receiver.getCommand_queue().take();
						System.out.println(command);
					} catch (InterruptedException e) {
						Thread.currentThread().interrupt();
					}
				}
				
			}
		});
		receiver_thread.start();
		
		
		
//		sender.send(new LightControlModesCommand(new LightControlModes(LightControlModes.Value.ON, LightControlModes.Value.ON, LightControlModes.Value.OFF)));
//		Thread.sleep(1000);
//		//
//		//sender.send(new RequestToSendCommand(6, 8));
//		//Thread.sleep(1);
//		sender.send(new StrobeTriggerCommand(Duration.ofMillis(10), Duration.ofMillis(10), 10));
//		Thread.sleep(1000);
		sender.send(new SettingsReadCommand(6));
//		Thread.sleep(1000);
//		receiver.close();
	}	
}