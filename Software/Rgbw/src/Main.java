import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import nl.rdrost.rgbw.comm.layers.bytes.ByteCommunication;
import nl.rdrost.rgbw.comm.layers.command.ApplyStripColorsCommand;
import nl.rdrost.rgbw.comm.layers.command.BootloaderCommand;
import nl.rdrost.rgbw.comm.layers.command.LightControlModesCommand;
import nl.rdrost.rgbw.comm.layers.command.Receiver;
import nl.rdrost.rgbw.comm.layers.command.Sender;
import nl.rdrost.rgbw.comm.layers.command.SettingsReadCommand;
import nl.rdrost.rgbw.comm.layers.command.SettingsWriteBasicCommand;
import nl.rdrost.rgbw.comm.layers.command.StripColorCommand;
import nl.rdrost.rgbw.comm.layers.command.StripTargetFactor;
import nl.rdrost.rgbw.comm.layers.command.StrobeColorCommand;
import nl.rdrost.rgbw.comm.layers.command.StrobeTriggerCommand;
import nl.rdrost.rgbw.comm.layers.command.StrobeWeightCommand;
import nl.rdrost.rgbw.comm.layers.session.Communication;
import nl.rdrost.rgbw.ledbar.BasicSettings;
import nl.rdrost.rgbw.types.LightControlModes;
import nl.rdrost.rgbw.types.Rgbw;

import org.apache.commons.cli.*;

import com.fasterxml.jackson.databind.ObjectMapper;

public class Main {
	public static final String ANSI_RESET = "\u001B[0m";
	public static final String ANSI_GREEN = "\u001B[32m";
	public static final String ANSI_BLUE  = "\u001B[34m";

	
	public static void main(final String[] args) throws IOException, InterruptedException {
		
		
		final Options options = new Options();
		
		final Option option_comm_port = new Option("c", "comm-port", true, "Comm-port to be used");
		options.addOption(option_comm_port);
		
		final Option option_list_devices = new Option("l", "list-devices", false, "Lists the devices on the bus");
		options.addOption(option_list_devices);
		
		final Option option_bootload = new Option("b", "bootload", true, "Send command to reset device to be bootloaded");
		option_bootload.setType(Number.class);
		options.addOption(option_bootload);
		
		final Option option_bootload_seconds = new Option(null, "bootload-seconds", true, "Time to wail till bootload (default = 5)");
		option_bootload_seconds.setType(Number.class);
		options.addOption(option_bootload_seconds);
		
		final Option option_read_settings = new Option(null, "read-settings", true, "Reads the settings of a device");
		option_read_settings.setType(Number.class);
		options.addOption(option_read_settings);
		
		final Option option_write_settings_file = new Option(null, "write-settings_file", true, "writes settings");
		option_write_settings_file.setType(String.class);
		options.addOption(option_write_settings_file);
		
		final String  comm_port;
		final boolean must_list_devices;
		final boolean must_bootload;
		final int     bootload_device_id;
		final int     bootload_seconds;
		final List<Integer> read_settings_id = new ArrayList<Integer>();
		final String  settings_file;
		try {
			CommandLineParser parser = new DefaultParser();
			CommandLine cmd = parser.parse(options, args);
			
			comm_port = (cmd.hasOption(option_comm_port))
					? (String)cmd.getParsedOptionValue(option_comm_port)
					: "/dev/ttyUSB0";
			
			must_list_devices = cmd.hasOption(option_list_devices);
			
			must_bootload = cmd.hasOption(option_bootload);
			bootload_device_id = must_bootload
					? ((Number)cmd.getParsedOptionValue(option_bootload)).intValue()
					: -1;
			bootload_seconds = cmd.hasOption(option_bootload_seconds)
					? ((Number)cmd.getParsedOptionValue(option_bootload_seconds)).intValue()
					: 6;
			
			if (cmd.hasOption(option_read_settings)) {
				read_settings_id.add(((Number)cmd.getParsedOptionValue(option_read_settings)).intValue());
			}
			
			settings_file = (cmd.hasOption(option_write_settings_file))
					? (String)cmd.getParsedOptionValue(option_write_settings_file)
				    : "";
			
		} catch (ParseException e) {
			e.printStackTrace();
			return;
		}
		
//		
		ByteCommunication receiverSender = new ByteCommunication(comm_port);
		Receiver receiver = new Receiver(receiverSender.getInputStream());
		Sender sender = new Sender(receiverSender.getOutputStream());
		Communication communication = new Communication(sender, receiver);
		communication.setSendOnRequest(true);
		
		if (must_list_devices) {
			communication.waitTillScanComplete();
			communication.close();
			
			communication.getDeviceIds().stream().forEach(System.out::println);
			return;
		}
		
		if (!settings_file.isEmpty()) {
			communication.send(new SettingsWriteBasicCommand(
					6,
					new BasicSettings.Builder()
						.setDeviceId(0)
						.setGroupId(0)
						.setSunId(0)
						.setStripId(0)
						.setStripReverse(false)
						.build()));
			communication.send(new SettingsWriteBasicCommand(
					5,
					new BasicSettings.Builder()
						.setDeviceId(1)
						.setGroupId(0)
						.setSunId(1)
						.setStripId(4)
						.setStripReverse(false)
						.build()));
			communication.send(new SettingsWriteBasicCommand(
					4,
					new BasicSettings.Builder()
						.setDeviceId(2)
						.setGroupId(0)
						.setSunId(2)
						.setStripId(7)
						.setStripReverse(false)
						.build()));
			communication.send(new SettingsWriteBasicCommand(
					3,
					new BasicSettings.Builder()
						.setDeviceId(3)
						.setGroupId(0)
						.setSunId(3)
						.setStripId(11)
						.setStripReverse(false)
						.build()));
			communication.send(new SettingsWriteBasicCommand(
					2,
					new BasicSettings.Builder()
						.setDeviceId(4)
						.setGroupId(0)
						.setSunId(4)
						.setStripId(15)
						.setStripReverse(false)
						.build()));
			communication.send(new SettingsWriteBasicCommand(
					1,
					new BasicSettings.Builder()
						.setDeviceId(5)
						.setGroupId(0)
						.setSunId(5)
						.setStripId(19)
						.setStripReverse(false)
						.build()));
		    
		}
		
		for (int unique_id : read_settings_id) {
			communication.send(new SettingsReadCommand(unique_id));
		}
		
		if (must_bootload) {
			communication.send(new BootloaderCommand(
					bootload_device_id, 
					bootload_seconds));
			communication.close();
			return;
		}
		
		communication.send(new LightControlModesCommand(new LightControlModes(LightControlModes.Value.ON, LightControlModes.Value.ON, LightControlModes.Value.NO_CHANGE)));
		communication.send(new StrobeWeightCommand(5*4, Arrays.asList(0.4f, 1.0f, 0.8f, 0.2f)));
		communication.send(new StrobeColorCommand(5*4, Arrays.asList(Rgbw.RED, Rgbw.GREEN, Rgbw.GREEN, Rgbw.RED)));
		
		final Rgbw strip_colors[] = new Rgbw[]{Rgbw.RED, Rgbw.GREEN, Rgbw.BLUE, Rgbw.WHITE};
		
		
		// Test
//		communication.setDebugPrintSender(Communication.DebugPrint.ON);
//		communication.setDebugPrintReceiver(Communication.DebugPrint.ON);
//		
//		communication.send(new SettingsReadCommand(7));
//		Thread.sleep(500);
//		communication.send(new SettingsWriteBasicCommand(7,
//				new BasicSettings.Builder()
//					.setStripId(0)
//					.setStripReverse(true)
//					.build()));
//		Thread.sleep(500);
//		communication.send(new SettingsReadCommand(7));
		
		// End test
		
		for (int i = 0; i < 0*40000; i++) {
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