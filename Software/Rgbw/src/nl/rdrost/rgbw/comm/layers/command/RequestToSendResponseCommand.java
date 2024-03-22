package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.BroadcastCommand;

public class RequestToSendResponseCommand extends BroadcastCommand {
	
	private final byte requested_length;
	
	public RequestToSendResponseCommand(final int requested_length) {
		super(INFO);
		
		assert(requested_length >= 0 && requested_length < 0xff);
		
		this.requested_length = (byte)requested_length;
	}
	
	public final int getRequestedLength() {
		return requested_length & 0xff;
	}
	
	@Override
	protected int getPayloadLength() {
		return 1;
	}

	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		payload.put(this.requested_length);
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RequestToSendResponseCommand [sender_unique_id=").append(getSenderUniqueId())
				.append(", requested_length=").append(requested_length)
				.append("]");
		return builder.toString();
	}

	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		
		@Override
		public final CommandId getCommand_id() {
			return CommandId.REQUEST_TO_SEND_RESPONSE;
		}
		
		@Override
		protected final AbstractCommand commandFrom(final ByteBuffer payload) {
			return new RequestToSendResponseCommand(
					payload.get());
		}
	};
}
