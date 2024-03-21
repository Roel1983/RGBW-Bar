package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;

import nl.rdrost.rgbw.comm.layer2.AbstractCommand;
import nl.rdrost.rgbw.comm.layer2.BroadcastCommand;
import nl.rdrost.rgbw.comm.layer2.CommandId;

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
