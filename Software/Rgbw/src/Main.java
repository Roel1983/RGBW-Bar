import java.io.IOException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import nl.rdrost.rgbw.comm.layers.bytes.ByteCommunication;
import nl.rdrost.rgbw.comm.layers.command.ApplyStripColorsCommand;
import nl.rdrost.rgbw.comm.layers.command.BootloaderCommand;
import nl.rdrost.rgbw.comm.layers.command.LightControlModesCommand;
import nl.rdrost.rgbw.comm.layers.command.Receiver;
import nl.rdrost.rgbw.comm.layers.command.Sender;
import nl.rdrost.rgbw.comm.layers.command.SettingsReadCommand;
import nl.rdrost.rgbw.comm.layers.command.StripColorCommand;
import nl.rdrost.rgbw.comm.layers.command.StripTargetFactor;
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
		communication.setSendOnRequest(true);
		
		communication.send(new LightControlModesCommand(new LightControlModes(LightControlModes.Value.ON, LightControlModes.Value.ON, LightControlModes.Value.NO_CHANGE)));
		communication.send(new StrobeWeightCommand(5*4, Arrays.asList(0.4f, 1.0f, 0.8f, 0.2f)));
		communication.send(new StrobeColorCommand(5*4, Arrays.asList(Rgbw.RED, Rgbw.GREEN, Rgbw.GREEN, Rgbw.RED)));
		
		final Rgbw strip_colors[] = new Rgbw[]{Rgbw.RED, Rgbw.GREEN, Rgbw.BLUE, Rgbw.WHITE};
		
		for (int i = 0; i < 40000; i++) {
			List<Rgbw> colors = new ArrayList<>();
			for (int j = 0; j < 40; j++) {
				colors.add(strip_colors[(i + j) % 4]);
			}
			communication.send(new StripColorCommand(0, colors));
			communication.send(new ApplyStripColorsCommand());
			for (int j = 1; j <= 10; j++) {
				communication.send(new StripTargetFactor(0.1f * j, Duration.ofMillis(100)));
				Thread.sleep(100);
			}
//			if((i % 4) ==  0) {
//				communication.send(new StrobeTriggerCommand(Duration.ofMillis(15), Duration.ofMillis(10), 5));
//			}
		}
		Thread.sleep(10000);
		communication.send(new BootloaderCommand(2, 6));
		Thread.sleep(1000);
		communication.close();
	}	
}