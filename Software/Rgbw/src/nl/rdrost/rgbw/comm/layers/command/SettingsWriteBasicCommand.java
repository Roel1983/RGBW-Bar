package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.UniqueIdCommand;
import nl.rdrost.rgbw.ledbar.BasicSettings;

public class SettingsWriteBasicCommand extends UniqueIdCommand {
	public static final CommandId COMMAND_ID = CommandId.SETTINGS_BASIC_WRITE;
	
	private final List<BasicSettings> settings;
	
	public SettingsWriteBasicCommand(final int unique_id, final BasicSettings settings) {
		this(unique_id, Arrays.asList(settings));
	}

	public SettingsWriteBasicCommand(final int unique_id, final List<BasicSettings> settings) {
		super(INFO, unique_id);
		Objects.nonNull(settings);
		
		assert(settings.stream().allMatch((BasicSettings s)->!Objects.isNull(s)));
		
		this.settings = Collections.unmodifiableList(new ArrayList<>(settings));
	}
	
	public final List<BasicSettings> getSettings() {
		return this.settings;
	}
	
	@Override
	protected int getPayloadLength() {
		return this.settings.size() * BasicSettings.PAYLOAD_SIZE;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		for (final BasicSettings settings : this.settings) {
			settings.putTo(payload);
		}
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SettingsBasicWriteCommand [sender_unique_id=").append(getSenderUniqueId())
				.append(", unique_id=").append(getUniqueId())
				.append(", settings=").append(settings)
				.append("]");
		return builder.toString();
	}

	public static UniqueIdCommand.Info INFO = new UniqueIdCommand.Info() {
		@Override
		public CommandId getCommand_id() {
			return CommandId.SETTINGS_BASIC_WRITE;
		}
		
		@Override
		protected AbstractCommand commandFrom(byte unique_id, ByteBuffer payload) {
			final int settings_count = payload.remaining() / BasicSettings.PAYLOAD_SIZE;
			final List<BasicSettings> settings_list = new ArrayList<>(settings_count);
			for (int i = 0; i < settings_count; i++) {
				final BasicSettings settings = BasicSettings.PARSER.parseFrom(payload);
				settings_list.add(settings);
			}
			return new SettingsWriteBasicCommand(unique_id, settings_list);
		}
	};
}
