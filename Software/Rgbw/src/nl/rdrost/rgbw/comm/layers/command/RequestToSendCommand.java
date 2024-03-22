package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.BroadcastCommand;

public class RequestToSendCommand extends BroadcastCommand {
	
	private final int unique_id;
	private final int max_length;
	
	public RequestToSendCommand(final int unique_id, final int max_length) {
		super(INFO);
		
		assert(unique_id  >= 0 && unique_id <  0xff);
		assert(max_length >= 0 && unique_id <= 0xff);
		
		this.unique_id  = unique_id;
		this.max_length = max_length;
	}
	
	public final int getUnique_id() {
		return this.unique_id;
	}
	
	public final int getMaxLength() {
		return this.max_length;
	}
	
	@Override
	protected int getPayloadLength() {
		return 2;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		payload
			.put((byte)this.unique_id)
			.put((byte)this.max_length);	
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RequestToSendCommand [sender_unique_id=").append(getSenderUniqueId())
				.append(", unique_id=").append(unique_id)
				.append(", max_length=").append(max_length)
				.append("]");
		return builder.toString();
	}

	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		@Override
		public CommandId getCommand_id() {
			return CommandId.REQUEST_TO_SEND;
		}
		
		@Override
		protected AbstractCommand commandFrom(final ByteBuffer payload) {
			return new RequestToSendCommand(
					payload.get(),
					payload.get());
		}
	};
}
