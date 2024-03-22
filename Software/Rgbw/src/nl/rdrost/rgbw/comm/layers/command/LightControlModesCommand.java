package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.BroadcastCommand;
import nl.rdrost.rgbw.types.LightControlModes;

public class LightControlModesCommand extends BroadcastCommand {
	private final LightControlModes modes;
	
	public LightControlModesCommand(final LightControlModes modes) {
		super(INFO);
		
		Objects.nonNull(modes);
		
		this.modes = modes;
	}
	
	@Override
	protected int getPayloadLength() {
		return 1;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		payload.put(modes.asByte());
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("LightControlModesCommand [sender_unique_id=").append(getSenderUniqueId())
				.append(", modes=").append(modes)
				.append("]");
		return builder.toString();
	}

	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		
		@Override
		public CommandId getCommand_id() {
			return CommandId.LIGHT_CONTROLLER_MODES;
		}
		
		@Override
		protected AbstractCommand commandFrom(final ByteBuffer payload) {
			return new LightControlModesCommand(
					LightControlModes.fromByte(payload.get()));
		}
	};
}
