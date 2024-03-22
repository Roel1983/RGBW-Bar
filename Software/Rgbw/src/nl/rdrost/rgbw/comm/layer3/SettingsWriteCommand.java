package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layer2.AbstractCommand;
import nl.rdrost.rgbw.comm.layer2.CommandId;
import nl.rdrost.rgbw.comm.layer2.UniqueIdCommand;
import nl.rdrost.rgbw.types.Settings;

public class SettingsWriteCommand extends UniqueIdCommand {
	public static final CommandId COMMAND_ID = CommandId.SETTINGS_WRITE;
	
	private final List<Settings> settings;
	
	public SettingsWriteCommand(final int unique_id, final Settings settings) {
		this(unique_id, Arrays.asList(settings));
	}

	public SettingsWriteCommand(final int unique_id, final List<Settings> settings) {
		super(INFO, unique_id);
		Objects.nonNull(settings);
		
		assert(settings.stream().allMatch((Settings s)->!Objects.isNull(s)));
		
		this.settings = Collections.unmodifiableList(new ArrayList<>(settings));
	}
	
	public final List<Settings> getSettings() {
		return this.settings;
	}
	
	@Override
	protected int getPayloadLength() {
		return this.settings.size() * Settings.PAYLOAD_SIZE;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		for (final Settings settings : this.settings) {
			settings.putTo(payload);
		}
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SettingsWriteCommand [settings=").append(settings).append("]");
		return builder.toString();
	}

	public static UniqueIdCommand.Info INFO = new UniqueIdCommand.Info() {
		@Override
		public CommandId getCommand_id() {
			return CommandId.SETTINGS_WRITE;
		}
		
		@Override
		protected AbstractCommand commandFrom(byte unique_id, ByteBuffer payload) {
			final int settings_count = payload.remaining() / Settings.PAYLOAD_SIZE;
			final List<Settings> settings_list = new ArrayList<>(settings_count);
			for (int i = 0; i < settings_count; i++) {
				final Settings settings = Settings.from(payload);
				settings_list.add(settings);
			}
			return new SettingsWriteCommand(unique_id, settings_list);
		}
	};
}
