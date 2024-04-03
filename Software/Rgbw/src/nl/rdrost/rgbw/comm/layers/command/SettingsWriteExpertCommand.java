package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.UniqueIdCommand;
import nl.rdrost.rgbw.ledbar.ExpertSettings;

public class SettingsWriteExpertCommand extends UniqueIdCommand {
	public static final CommandId COMMAND_ID = CommandId.SETTINGS_EXPERT_WRITE;
	
	private final List<ExpertSettings> settings;
	
	public SettingsWriteExpertCommand(final int unique_id, final ExpertSettings settings) {
		this(unique_id, Arrays.asList(settings));
	}

	public SettingsWriteExpertCommand(final int unique_id, final List<ExpertSettings> settings) {
		super(INFO, unique_id);
		Objects.nonNull(settings);
		
		assert(settings.stream().allMatch((ExpertSettings s)->!Objects.isNull(s)));
		
		this.settings = Collections.unmodifiableList(new ArrayList<>(settings));
	}
	
	public final List<ExpertSettings> getSettings() {
		return this.settings;
	}
	
	@Override
	protected int getPayloadLength() {
		return this.settings.size() * ExpertSettings.PAYLOAD_SIZE;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		for (final ExpertSettings settings : this.settings) {
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
			return CommandId.SETTINGS_EXPERT_WRITE;
		}
		
		@Override
		protected AbstractCommand commandFrom(byte unique_id, ByteBuffer payload) {
			final int settings_count = payload.remaining() / ExpertSettings.PAYLOAD_SIZE;
			final List<ExpertSettings> settings_list = new ArrayList<>(settings_count);
			for (int i = 0; i < settings_count; i++) {
				final ExpertSettings settings = ExpertSettings.PARSER.parseFrom(payload);
				settings_list.add(settings);
			}
			return new SettingsWriteExpertCommand(unique_id, settings_list);
		}
	};
}
