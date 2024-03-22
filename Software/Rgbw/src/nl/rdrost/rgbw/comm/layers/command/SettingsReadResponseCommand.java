package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.BroadcastCommand;
import nl.rdrost.rgbw.types.Settings;

public class SettingsReadResponseCommand extends BroadcastCommand {
	
	private final Settings settings;
	
	public SettingsReadResponseCommand(final Settings settings) {
		super(INFO);
		
		Objects.nonNull(settings);
		
		this.settings = settings;
	}
	
	public final Settings getSettings() {
		return this.settings;
	}

	@Override
	protected int getPayloadLength() {
		return Settings.PAYLOAD_SIZE;
	}

	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		this.settings.putTo(payload);
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SettingsReadResponseCommand [settings=").append(settings)
				.append("]");
		return builder.toString();
	}

	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		@Override
		public CommandId getCommand_id() {
			return CommandId.SETTINGS_READ_RESPONSE;
		}
		
		@Override
		protected AbstractCommand commandFrom(final ByteBuffer payload) {
			return new SettingsReadResponseCommand(
					Settings.from(payload));
		}
	};
}
