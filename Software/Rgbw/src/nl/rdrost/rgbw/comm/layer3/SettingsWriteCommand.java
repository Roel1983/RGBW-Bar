package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

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
		super(COMMAND_ID, unique_id);
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
	protected void payloadPutTo(	final ByteBuffer payload) {
		for (final Settings settings : this.settings) {
			settings.putTo(payload);
		}
	}
}
