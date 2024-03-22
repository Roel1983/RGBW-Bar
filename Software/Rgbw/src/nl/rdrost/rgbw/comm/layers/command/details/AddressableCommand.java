package nl.rdrost.rgbw.comm.layers.command.details;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import nl.rdrost.rgbw.comm.layers.packet.Command;

public abstract class AddressableCommand extends AbstractCommand {
	public static final int MAX_BLOCK_ID = 0xFE;
	
	private final byte block_id;
	
	protected AddressableCommand(final AbstractCommand.Info info, final int block_id) {
		super(info);
		assert(block_id >= 0 && block_id <= MAX_BLOCK_ID);
		
		this.block_id = (byte)block_id; 
	}
	
	protected final int getBlockId() {
		return this.block_id;
	}
		
	@Override
	protected nl.rdrost.rgbw.comm.layers.packet.Command createCommand() {
		
		final int body_length = getPayloadLength();
		assert(body_length >= 0 && body_length < 0x8fff);
		final ByteBuffer body = ByteBuffer.allocate(1 + body_length)
				.order(ByteOrder.LITTLE_ENDIAN)
				.put(block_id);
		payloadPutTo(body);
		return new nl.rdrost.rgbw.comm.layers.packet.Command(
				(byte)0xff,	this.info.getCommand_id().value, body.flip());
	}
	
	public static abstract class Info extends AbstractCommand.Info {
		
		public Info(AbstractCommand.Info.Type type) {
			super(type);
		}
		
		@Override
		public final AbstractCommand commandFrom(final Command layer1_command) {
			final ByteBuffer body = layer1_command.getBody();
			
			byte block_id            = body.get();
			final ByteBuffer payload = body;
			return commandFrom(block_id, payload);
		}
		
		protected abstract AbstractCommand commandFrom(final byte block_id, final ByteBuffer payload);
	}
}
