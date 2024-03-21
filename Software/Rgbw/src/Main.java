import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.Duration;
import java.util.Arrays;

import com.fazecast.jSerialComm.SerialPort;

import nl.rdrost.rgbw.comm.layer1.Receiver;
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
		
//		Receiver receiver = new Receiver();
//		comPort.addDataListener(new SerialPortDataListener() {
//			private byte buffer[] = new byte[10];//comPort.getDeviceReadBufferSize()];
//			
//			@Override
//			public int getListeningEvents() {
//				return SerialPort.LISTENING_EVENT_DATA_AVAILABLE;
//			}
//
//			@Override
//			public void serialEvent(SerialPortEvent event) {
//				if (event.getEventType() == SerialPort.LISTENING_EVENT_DATA_AVAILABLE) {
//					int bytes_to_read = comPort.bytesAvailable();
//					
//					while (bytes_to_read > 0) {
//						int bytes_read = comPort.readBytes(buffer, Math.min(buffer.length, bytes_to_read));
//						System.out.print(ANSI_GREEN);
//						for(int i = 0; i < bytes_read; i++) {
//							System.out.format("<%02X>", buffer[i] & 0xff);
//						}
//						System.out.print(ANSI_RESET);
//						
//						receiver.onReceivedBytes(buffer, bytes_read);
//						
//						bytes_to_read = comPort.bytesAvailable();
//					}
//				}
//			}
//		});
		
		Sender sender = new Sender(os);
		
		sender.send(new LightControlModesCommand(new LightControlModes(LightControlModes.Value.ON, LightControlModes.Value.ON, LightControlModes.Value.OFF)));
		Thread.sleep(1000);
		//
		sender.send(new RequestToSendCommand(5, 8));
		Thread.sleep(1);
		sender.send(new StrobeTriggerCommand(Duration.ofMillis(10), Duration.ofMillis(10), 10));
		Thread.sleep(1000);
		//sender.send(new BootloaderCommand(5, 6));
		//Thread.sleep(100);
		//receiver.close();
		
		
//		Command lightControlModesCommand1 = new LichtControlModesCommand(new LichtControlModes(
//				LichtControlModes.Value.ON,
//				LichtControlModes.Value.ON,
//				LichtControlModes.Value.OFF));
//		
//		Command lightControlModesCommand2 = new LichtControlModesCommand(new LichtControlModes(
//				LichtControlModes.Value.ON,
//				LichtControlModes.Value.NO_CHANGE,
//				LichtControlModes.Value.ON));
//		Command bootloaderCommand = new BootloaderCommand(5, 1);
		
//		AbstractCommand strobeWeightsCommand = new StrobeWeightCommand(
//				(byte)6, Arrays.asList(0.2f, 0.4f, 0.8f, 1.0f));
//		AbstractCommand strobeTriggerCommand = new StrobeTriggerCommand(
//				Duration.ofMillis(10), Duration.ofMillis(10), 10);
//		
//		AbstractCommand settingsWrite = new SettingsWriteCommand(
//				6,
//				new Settings((byte)6, (byte)6, (byte)0, (byte)6, (byte)(6*4),
//						new Rgbw(new short[]{4000,2000,2000,0}),
//						new Rgbw(new short[]{4000,2000,2000,0})));
//		
////		commandSender.send(new SettingsReadCommand(5).asCommand());
////		Thread.sleep(10);
//		
//		//commandSender.send(settingsWrite.asCommand());
//		commandSender.send(lightControlModesCommand1.asCommand());
//		Thread.sleep(1000);
//		commandSender.send(strobeWeightsCommand.asCommand()); // Doesn´t work
//		commandSender.send(strobeTriggerCommand.asCommand());
//		Thread.sleep(1000);
//		commandSender.send(lightControlModesCommand2.asCommand());
//		
//		Thread.sleep(2000);
//		commandSender.send(bootloaderCommand.asCommand());
	}	
}
/*
enum CommandId {
	LIGHT_CONTROLLER_MODES ((byte) 2),
	BOOTLOADER             ((byte) 3),
	STRIP_COLOR            ((byte) 4),
	STRIP_TARGET_FACTOR    ((byte) 5),
	STROBE_TRIGGER         ((byte) 6),
	STROBE_COLOR           ((byte) 7),
	STROBE_WEIGHT          ((byte) 8),
	SETTINGS_READ          ((byte) 9),
	SETTINGS_WRITE         ((byte)11);
	
	public final byte value;
	
	private CommandId(byte value) {
		this.value = value;
	}
}

class LichtControlModesCommand extends BroadcastCommand { // Should be GroupCommand
	public static final CommandId COMMAND_ID = CommandId.LIGHT_CONTROLLER_MODES;
	
	public static class Modes {
		public static enum Value {
			NO_CHANGE ((byte)0b00),
			OFF       ((byte)0b01),     
			ON        ((byte)0b10),
			TOGGLE    ((byte)0b11);
			
			public final byte value;
			
			private Value(final byte value) {
				this.value = value;
			}
		}
		
		private final Value main;
		private final Value follow;
		private final Value flut;
		
		public Modes(final Value main, final Value follow, final Value flut) {
			Objects.nonNull(main);
			Objects.nonNull(follow);
			Objects.nonNull(flut);
			
			this.main   = main;
			this.follow = follow;
			this.flut   = flut;
		}
		
		public final Value getMain() {
			return this.main;
		}
		
		public final Value getFollow() {
			return this.follow;
		}
		
		public final Value getFlut() {
			return this.flut;
		}
		
		public byte asByte() {
			return (byte)(this.main.value   << 0
					    | this.follow.value << 2
				        | this.flut.value   << 4);
		}
	}
	
	private final Modes modes;
	
	public LichtControlModesCommand(final Modes modes) {
		super(COMMAND_ID);
		
		Objects.nonNull(modes);
		
		this.modes = modes;
	}
	
	@Override
	protected ByteBuffer getPayload() {
		return ByteBuffer.allocate(1).put(modes.asByte()).flip();
	}
}

class BootloaderCommand extends BroadcastCommand {
	public static final CommandId COMMAND_ID = CommandId.BOOTLOADER;
	
	private final int unique_id;
	private final int seconds;
	
	public BootloaderCommand(final int unique_id, final int seconds) {
		super(COMMAND_ID);
		
		assert(unique_id >= 0 && unique_id < 0xff);
		assert(seconds >= 0   && seconds < 0xff);
		
		this.unique_id = unique_id;
		this.seconds   = seconds;
	}
	
	public final int getUniqueId() {
		return this.unique_id;
	}
	
	public final int getSeconds() {
		return this.seconds;
	}
	
	@Override
	protected ByteBuffer getPayload() {
		return ByteBuffer.allocate(2)
				.put((byte)this.unique_id)
				.put((byte)this.seconds)
				.flip();
	}
}

class StrobeTriggerCommand extends BroadcastCommand { // Should be GroupCommand
	public static final CommandId COMMAND_ID = CommandId.STROBE_TRIGGER;
	
	public static final Duration MAX_DURATION = Duration.ofMillis(0xFFFF);
	public static final int      MAX_COUNT    = 0xFF;
	
	private final Duration on;
	private final Duration off;
	private final int      count;
	
	public StrobeTriggerCommand(final Duration on, final Duration off, final int count) {
		super(COMMAND_ID);
		Objects.nonNull(on);
		Objects.nonNull(off);
		
		assert(!on.isNegative()  && !on.isZero()  && on.compareTo(MAX_DURATION)  <= 0);
		assert(!off.isNegative() && !off.isZero() && off.compareTo(MAX_DURATION) <= 0);
		assert(count <= MAX_COUNT);
		
		this.on    = on;
		this.off   = off;
		this.count = count;
	}
	
	@Override
	protected ByteBuffer getPayload() {
		return ByteBuffer.allocate(5)
				.order(ByteOrder.LITTLE_ENDIAN)
				.putShort((short)this.on.toMillis())
				.putShort((short)this.off.toMillis())
				.put((byte)this.count)
				.flip();
	}
}

class StrobeWeightCommand extends StripCommand {
	public static final CommandId COMMAND_ID = CommandId.STROBE_WEIGHT;
	
	private final List<Float> weights;
	
	protected StrobeWeightCommand(final int strip_id, final float weight) {
		this(strip_id, Arrays.asList(weight));
	}
	
	protected StrobeWeightCommand(final int strip_id, final List<Float> weights) {
		super(COMMAND_ID, strip_id);
		Objects.nonNull(weights);
		
		assert(weights.stream().allMatch((Float f)->!Objects.isNull(f) && f >= 0 && f <= 8192));
		
		this.weights = Collections.unmodifiableList(new ArrayList<>(weights));
	}
	
	@Override
	protected ByteBuffer getPayload() {
		ByteBuffer payload = ByteBuffer.allocate(2 * this.weights.size())
				.order(ByteOrder.LITTLE_ENDIAN);
		for (final float weight : this.weights) {
			payload.putShort((short)(weight * 8192));
		}
		return payload.flip();
	}
}

class Rgbw {
	public static final int CHANNEL_COUNT = 4;
	public static final int CHANNEL_MAX   = 4085;
	public static final int PAYLOAD_SIZE  = CHANNEL_COUNT * 2;
	
	final short[] channels;
	
	public Rgbw(final short[] channels) {
		Objects.nonNull(channels);
		assert(channels.length == CHANNEL_COUNT);
		for (final short s : channels) {
			assert(s >= 0 && s <= CHANNEL_MAX);
		}
		this.channels = Arrays.copyOf(channels, CHANNEL_COUNT);
	}

	public void putTo(final ByteBuffer payload) {
		payload.order(ByteOrder.LITTLE_ENDIAN);
		for (final short s : channels) {
			payload.putShort(s);
		}
	}
}

class Settings {
	public  static final int PAYLOAD_SIZE = 9 + 2 * Rgbw.PAYLOAD_SIZE;
	private static final int CRC_PRIME = 31;
	
	private final byte unique_id;
	private final byte device_id;
	private final byte group_id;
	private final byte sun_id;
	private final byte strip_id;
	private final Rgbw work_light_color;
	private final Rgbw flut_light_color;
	
	public Settings(final byte unique_id, final byte device_id, final byte group_id, final byte sun_id, 
			final byte strip_id, final Rgbw work_light_color, final Rgbw flut_light_color
	) {
		Objects.nonNull(work_light_color);
		Objects.nonNull(flut_light_color);
		
		this.unique_id = unique_id;
		this.device_id = device_id;
		this.group_id  = group_id;
		this.sun_id    = sun_id;
		this.strip_id  = strip_id;
		this.work_light_color = work_light_color;
		this.flut_light_color = flut_light_color;
	}
	
	// TODO getters

	public void putTo(final ByteBuffer payload) {
		
		int crc_position = payload.position();
		payload.position(crc_position + 4);
		payload.put(this.unique_id);
		payload.put(this.device_id);
		payload.put(this.group_id);
		payload.put(this.sun_id);
		payload.put(this.strip_id);
		
		this.work_light_color.putTo(payload);
		this.flut_light_color.putTo(payload);
		
		ByteBuffer bb = payload.duplicate().flip().position(crc_position + 4);
		int crc = 1;
		while (bb.hasRemaining()) {
			 crc += bb.get();
			 crc *= CRC_PRIME;
		}
		payload.putInt(crc_position, crc);
	}
}

class SettingsReadCommand extends UniqueIdCommand {
	public static final CommandId COMMAND_ID = CommandId.SETTINGS_READ;
	
	private final int count;
	
	public SettingsReadCommand(final int unique_id) {
		this(unique_id, 1);
	}
	
	public SettingsReadCommand(final int unique_id, final int count) {
		super(COMMAND_ID, unique_id);
		
		assert(count > 0 && unique_id + count < 0xff);
		
		this.count = count;
	}
	
	public final int getCount() {
		return this.count;
	}
	
	@Override
	protected ByteBuffer getPayload() {
		ByteBuffer payload = ByteBuffer.allocate(this.count);
		for (int i = 0; i < this.count; i++) {
			payload.put((byte)0x00);
		}
		return payload.flip();
	}
}

class SettingsWriteCommand extends UniqueIdCommand {
	public static final CommandId COMMAND_ID = CommandId.SETTINGS_WRITE;
	
	private final List<Settings> settings;
	
	public SettingsWriteCommand(final int unique_id, final Settings settings) {
		this(unique_id, Arrays.asList(settings));
	}

	public SettingsWriteCommand(final int unique_id, final List<Settings> settings) {
		super(COMMAND_ID, unique_id);
		Objects.nonNull(settings);
		
		assert(settings.stream().allMatch((Settings s)->!Objects.isNull(s)));
		
		this.settings = Collections.unmodifiableList(new ArrayList<>(settings));
	}
	
	public final List<Settings> getSettings() {
		return this.settings;
	}

	@Override
	protected ByteBuffer getPayload() {
		ByteBuffer payload = ByteBuffer.allocate(this.settings.size() * Settings.PAYLOAD_SIZE)
				.order(ByteOrder.LITTLE_ENDIAN);
		for (final Settings settings : this.settings) {
			settings.putTo(payload);
		}
		return payload;
	}}

abstract class AbstractCommand {
	private Command           command = null;
	protected final CommandId command_id;
	
	public AbstractCommand(CommandId command_id) {
		Objects.nonNull(command_id);
		this.command_id = command_id;
	}
	
	public final CommandId getCommandId() {
		return this.command_id;
	}
	
	public final Command asCommand() {
		if (Objects.isNull(command)) {
			command = createCommand();
		}
		return command;
	}
	protected abstract ByteBuffer getPayload();
	protected abstract Command createCommand();
}

abstract class BroadcastCommand extends AbstractCommand {
	
	protected BroadcastCommand(final CommandId command_id) {
		super(command_id);
	}
	
	@Override
	protected Command createCommand() {
		return new Command((byte)0xff, this.command_id.value, null, getPayload());
	}
}

abstract class AddressableCommand extends AbstractCommand {
	public static final int MAX_BLOCK_ID = 0xFE;
	
	private final int block_id;
	
	protected AddressableCommand(final CommandId command_id, final int block_id) {
		super(command_id);
		assert(block_id >= 0 && block_id <= MAX_BLOCK_ID);
		
		this.block_id = block_id; 
	}
	
	protected final int getBlockId() {
		return this.block_id;
	}
		
	@Override
	protected Command createCommand() {
		return new Command((byte)0xff, this.command_id.value, (byte)block_id, getPayload());
	}
}

abstract class UniqueIdCommand extends AddressableCommand {

	protected UniqueIdCommand(final CommandId command_id, final int unique_id) {
		super(command_id, unique_id);
	}
	
	public final int getUniqueId() {
		return getBlockId();
	}
}

abstract class DeviceCommand extends AddressableCommand {

	protected DeviceCommand(final CommandId command_id, final int device_id) {
		super(command_id, device_id);
	}
	
	public final int getDeviceId() {
		return getBlockId();
	}
}

abstract class GroupCommand extends AddressableCommand {

	protected GroupCommand(final CommandId command_id, final int group_id) {
		super(command_id, group_id);
	}
	
	public final int getGroupId() {
		return getBlockId();
	}
}

abstract class StripCommand extends AddressableCommand {

	protected StripCommand(final CommandId command_id, final int strip_id) {
		super(command_id, strip_id);
	}
	
	public final int getStripId() {
		return getBlockId();
	}
}

class CommandSender {
	private final OutputStream os;
	
	public CommandSender(OutputStream os) {
		this.os = os;
	}
	
	public final OutputStream getOutputStream() {
		return this.os;
	}
	
	public void send(final Command command) throws IOException {
		ByteBuffer payload = command.payload.duplicate();
		os.write(0x55);
		os.write(0x55);
		os.write(command.sender_unique_id);
		os.write(command.command_id);
		int payload_length = payload.remaining(); // TODO extended length
		byte crc = (byte)(0 - command.sender_unique_id - command.command_id - payload_length);		
		if (!Objects.isNull(command.block_id)) {
			os.write(payload_length + 1);
			os.write(command.block_id);
			crc -= 1 + command.block_id;
		} else {
			os.write(payload_length);
		}
		
		while (payload.hasRemaining()) {
			byte b = payload.get();
			os.write(b);
			crc -= b;
		}	
		os.write(crc);		
	}
}


class Command {
	final byte       sender_unique_id;
	final byte       command_id;
	final Byte       block_id;
	final ByteBuffer payload;
	
	public Command(
		byte             sender_unique_id,
		final byte       command_id,
		final Byte       block_id,
		final ByteBuffer payload
	) {
		this.sender_unique_id = sender_unique_id;
		this.command_id       = command_id;
		this.block_id         = block_id;
		this.payload          = payload.asReadOnlyBuffer();
	}
}*/