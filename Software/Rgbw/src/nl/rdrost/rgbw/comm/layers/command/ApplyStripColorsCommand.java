package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.BroadcastCommand;

public class ApplyStripColorsCommand extends BroadcastCommand {
	
	public ApplyStripColorsCommand() {
		super(INFO);
	}
	
	@Override
	protected int getPayloadLength() {
		return 1;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		payload
			.put((byte)0x00);
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ApplyStripColorsCommand [sender_unique_id=").append(getSenderUniqueId())
				.append("]");
		return builder.toString();
	}

	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		
		@Override
		public CommandId getCommand_id() {
			return CommandId.APPLY_STRIP_COLORS;
		}
		
		@Override
		protected AbstractCommand commandFrom(final ByteBuffer payload) {
			payload.get();
			return new ApplyStripColorsCommand();
		}
	};
}
