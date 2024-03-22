import java.io.IOException;
import java.time.Duration;
import java.util.Arrays;

import nl.rdrost.rgbw.comm.layers.bytes.ByteCommunication;
import nl.rdrost.rgbw.comm.layers.command.BootloaderCommand;
import nl.rdrost.rgbw.comm.layers.command.LightControlModesCommand;
import nl.rdrost.rgbw.comm.layers.command.Receiver;
import nl.rdrost.rgbw.comm.layers.command.Sender;
import nl.rdrost.rgbw.comm.layers.command.SettingsReadCommand;
import nl.rdrost.rgbw.comm.layers.command.StrobeColorCommand;
import nl.rdrost.rgbw.comm.layers.command.StrobeTriggerCommand;
import nl.rdrost.rgbw.comm.layers.command.StrobeWeightCommand;
import nl.rdrost.rgbw.comm.layers.session.Communication;
import nl.rdrost.rgbw.types.LightControlModes;
import nl.rdrost.rgbw.types.Rgbw;

public class Main {
	public static final String ANSI_RESET = "\u001B[0m";
	public static final String ANSI_GREEN = "\u001B[32m";
	public static final String ANSI_BLUE  = "\u001B[34m";

	
	public static void main(String[] args) throws IOException, InterruptedException {

		ByteCommunication receiverSender = new ByteCommunication("/dev/ttyUSB0");
		Receiver receiver = new Receiver(receiverSender.getInputStream());
		Sender sender = new Sender(receiverSender.getOutputStream());
		Communication communication = new Communication(sender, receiver);
		
		communication.send(new LightControlModesCommand(new LightControlModes(LightControlModes.Value.ON, LightControlModes.Value.ON, LightControlModes.Value.NO_CHANGE)));
		communication.send(new StrobeWeightCommand(6, Arrays.asList(0.1f, 0.2f, 0.4f, 0.8f)));
		communication.send(new StrobeColorCommand(6, Arrays.asList(Rgbw.RED)));
		
		Thread.sleep(1000);
		communication.send(new StrobeTriggerCommand(Duration.ofMillis(15), Duration.ofMillis(10), 5));
//		Thread.sleep(1000);
//		communication.send(new SettingsReadCommand(5));
		Thread.sleep(1000);
		for (int i = 0; i < 3; i++) {
			communication.send(new StrobeTriggerCommand(Duration.ofMillis(15), Duration.ofMillis(10), 5));
			Thread.sleep(1000);
		}
		communication.send(new BootloaderCommand(5, 6));
		Thread.sleep(1000);
		communication.close();
	}	
}