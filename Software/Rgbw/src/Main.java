import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.Duration;
import java.time.Period;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.EnumMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.SourceDataLine;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
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
import nl.rdrost.rgbw.comm.layers.session.Communication.DebugPrint;
import nl.rdrost.rgbw.drivers.Drivers;
import nl.rdrost.rgbw.drivers.Drivers.DriverType;
import nl.rdrost.rgbw.ledbar.BasicSettings;
import nl.rdrost.rgbw.types.LightControlModes;
import nl.rdrost.rgbw.types.Rgbw;
import nl.rdrost.rgbw.valuepicker.GradientValuePicker;
import nl.rdrost.rgbw.valuepicker.ValuePicker;
import nl.rdrost.rgbw.valuepicker.gradient.Gradient;
import nl.rdrost.rgbw.valuepicker.gradient.GradientFactory;
import nl.rdrost.rgbw.valuepicker.gradient.LinearGradient;

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
		communication.setDebugPrintSender(DebugPrint.ON_ALL);
		communication.setDebugPrintReceiver(DebugPrint.ON_ALL);
		//communication.setSendOnRequest(true);
		
		if (must_list_devices) {
			communication.waitTillScanComplete();
			communication.close();
			
			communication.getDeviceIds().stream().forEach(System.out::println);
			return;
		}
		
		if (!settings_file.isEmpty()) {
			communication.send(new SettingsWriteBasicCommand(
					7,
					new BasicSettings.Builder()
						.setDeviceId(4)
						.setGroupId(0)
						.setSunId(4)
						.setStripId(15)
						.setStripReverse(false)
						.build()));
			communication.send(new SettingsWriteBasicCommand(
					6,
					new BasicSettings.Builder()
						.setDeviceId(0)
						.setGroupId(0)
						.setSunId(0)
						.setStripId(7)
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
			Thread.sleep(1000);
			communication.close();
			return;
		}
		
		if (!read_settings_id.isEmpty()) {
			communication.setDebugPrintReceiver(DebugPrint.ON);
			for (int unique_id : read_settings_id) {
				communication.send(new SettingsReadCommand(unique_id));
			}
			communication.waitTillScanComplete();
			communication.close();
			return;
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
		
		// TODO from JSON
		LinearGradient<Rgbw> gradient = new GradientFactory<>(Rgbw.class)
				.put(0.00f, new Rgbw(0.0f, 0.0f, 0.5f, 0.0f)) // Dark blue 
				.put(0.15f, new Rgbw(0.0f, 0.0f, 1.0f, 0.0f)) // Deep blue
				.put(0.24f, new Rgbw(0.3f, 0.3f, 0.3f, 0.0f)) // Gray
				.put(0.25f, new Rgbw(1.0f, 0.0f, 0.0f, 0.0f)) // Deep red
				.put(0.30f, new Rgbw(1.0f, 0.8f, 0.0f, 0.0f)) // Orange
				.put(0.45f, new Rgbw(1.0f, 1.0f, 0.8f, 1.0f)) // bright warm white
				.put(0.55f, new Rgbw(1.0f, 1.0f, 0.8f, 1.0f)) // bright warm white
				.put(0.70f, new Rgbw(1.0f, 0.8f, 0.0f, 0.0f)) // Orange
				.put(0.75f, new Rgbw(1.0f, 0.0f, 0.0f, 0.0f)) // Deep red
				.put(0.76f, new Rgbw(0.3f, 0.3f, 0.3f, 0.0f)) // Gray
				.put(0.85f, new Rgbw(0.0f, 0.0f, 1.0f, 0.0f)) // Deep blue
				.create();
		ValuePicker<Rgbw> rgbw_picker = GradientValuePicker.createFirstOrder(Arrays.asList(DriverType.TIME), gradient);
		
		
		File audioFile = new File("/media/roel/e1a79f3c-83dd-421f-91e3-d0d95d706cc7/roel/Projects/day and night/dag-nacht-opendag/tmp/haan1.wav");
		Clip audioClip1 = null;
		try {
			AudioInputStream audioStream = AudioSystem.getAudioInputStream(audioFile);
			AudioFormat format = audioStream.getFormat();
			DataLine.Info info = new DataLine.Info(Clip.class, format);
			audioClip1 = (Clip) AudioSystem.getLine(info);
			audioClip1.open(audioStream);
		} catch (UnsupportedAudioFileException | LineUnavailableException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		final Clip audioClip = audioClip1;
		
		DriverEvent driverEvent = new DriverEvent.Builder().setCondition(DriverType.TIME, DriverEvent.Event.BECOME_GREATER, 0.25f).build(()->{
			if (audioClip != null) {
				audioClip.setFramePosition(0);
				audioClip.start();
			}
		});
		
		Drivers drivers = new Drivers();
		drivers.setDriver(DriverType.WEATHER,    1.0f);
		drivers.setDriver(DriverType.CLOUDINESS, 0.75f);
		long period = 1000 * 60 * 1;
		
		while(true) {
			// Determine the drivers for this frame
			drivers.setDriver(DriverType.TIME, (float)(System.currentTimeMillis() % period) / period);
			
			// Pick the colors for each strip and send it
			List<Rgbw> colors = new ArrayList<>();
			for (int j = 0; j < 10; j++) {
				colors.add(rgbw_picker.get(drivers));
			}
			communication.send(new StripColorCommand(7, colors));
			colors = new ArrayList<>();
			for (int j = 10; j < 20; j++) {
				colors.add(rgbw_picker.get(drivers));
			}
			communication.send(new StripColorCommand(17, colors));
			
			// Apply and fade the colors			
			communication.send(new ApplyStripColorsCommand());
			communication.send(new StripTargetFactor(1.0f, Duration.ofMillis(1000)));
			Thread.sleep(1000);
			driverEvent.loop(drivers);
		}
//		communication.close();
//		audioClip.close();
//		audioStream.close();

	}
	
}

class DriverEvent {
	
	public static enum Event {
		ALWAYS {
			@Override
			boolean updateIsActive(DriverEvent.Condition condition, float driver) {
				return condition.is_active = true;
			}
		},
		GREATER_THAN {
			@Override
			boolean updateIsActive(DriverEvent.Condition condition, float driver) {
				final float effective_threshold = condition.threshold 
						                        + condition.hysteresis * (condition.is_active ? -.5f : .5f);
				return condition.is_active = (1.0f + driver - effective_threshold) % 1.0f < 0.5f;
			}
		},
		SMALLER_THAN {
			@Override
			boolean updateIsActive(DriverEvent.Condition condition, float driver) {
				final float effective_threshold = condition.threshold 
                        + condition.hysteresis * (condition.is_active ? .5f : -.5f);
				return condition.is_active = (1.0f + driver - effective_threshold) % 1.0f > 0.5f;
			}
		},
		BECOME_GREATER {
			@Override
			boolean updateIsActive(DriverEvent.Condition condition, float driver) {
				final boolean old_is_active = condition.is_active;
				final float effective_threshold = condition.threshold 
                        + condition.hysteresis * (condition.is_active ? -.5f : .5f);
				condition.is_active = condition.is_active = (1.0f + driver - effective_threshold) % 1.0f < 0.5f;
				return !old_is_active && condition.is_active;
			}
		},
		BECOME_SMALLER {
			@Override
			boolean updateIsActive(DriverEvent.Condition condition, float driver) {
				final boolean old_is_active = condition.is_active;
				final float effective_threshold = condition.threshold 
                        + condition.hysteresis * (condition.is_active ? .5f : -.5f);
				condition.is_active = (1.0f + driver - effective_threshold) % 1.0f > 0.5f;
				return !old_is_active && condition.is_active;
			}
		},
		NEVER {
			@Override
			boolean updateIsActive(DriverEvent.Condition condition, float driver) {
				return condition.is_active = false;
			}
		};

		abstract boolean updateIsActive(DriverEvent.Condition condition, float driver);
	}
	
	public static class Builder {
		public final static float DEFAULT_HYSTERESIS = 0.0f;
		
		private final Map<DriverType, Condition> conditions = new EnumMap<>(DriverType.class);
		
		Builder setCondition(final DriverType driver_type, final Event event, final float threshold) {
			return setCondition(driver_type, event, threshold, DEFAULT_HYSTERESIS);
		}
		
		Builder setCondition(final DriverType driver_type, final Event event, final float threshold, final float hysteresis) {
			conditions.put(driver_type, new Condition(event, threshold, hysteresis));
			return this;
		}
		
		public DriverEvent build(Runnable action) {
			// TODO sanity check:
			return new DriverEvent(this.conditions, action);
		}
	}
	
	private static class Condition {
		public final float  threshold;    
		public final float  hysteresis; 
		public final Event  event;
		
		public boolean      is_active;
		
		public Condition(DriverEvent.Event event, float threshold, float  hysteresis) {
			super();
			Objects.nonNull(event);
			this.threshold  = threshold;
			this.hysteresis = hysteresis;
			this.event      = event;
		}
	}
	
	private final Map<DriverType, Condition> conditions;
	private final Runnable action;
	private boolean is_active = true;
	
	private DriverEvent(final Map<DriverType, DriverEvent.Condition> conditions, Runnable action) {
		this.conditions = conditions;
		this.action     = action;
	}
	
	public void loop(final Drivers drivers) {
		boolean new_is_active = true;
		for (Map.Entry<DriverType, DriverEvent.Condition> pair : conditions.entrySet()) {
			final DriverType driver_type = pair.getKey();
			final Condition  condition   = pair.getValue();
			
			if(!condition.event.updateIsActive(condition, drivers.getDriver(driver_type))) {
				new_is_active = false;
			};
		}
		if (!is_active && new_is_active) {
			this.action.run();
		}
		is_active = new_is_active;
	}
}
