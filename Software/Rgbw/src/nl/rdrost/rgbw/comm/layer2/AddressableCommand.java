package nl.rdrost.rgbw.comm.layer2;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

public abstract class AddressableCommand extends AbstractCommand {
	public static final int MAX_BLOCK_ID = 0xFE;
	
	private final byte block_id;
	
	protected AddressableCommand(final CommandId command_id, final int block_id) {
		super(command_id);
		assert(block_id >= 0 && block_id <= MAX_BLOCK_ID);
		
		this.block_id = (byte)block_id; 
	}
	
	protected final int getBlockId() {
		return this.block_id;
	}
		
	@Override
	protected nl.rdrost.rgbw.comm.layer1.Command createCommand() {
		
		final int body_length = getPayloadLength();
		assert(body_length >= 0 && body_length < 0x8fff);
		final ByteBuffer body = ByteBuffer.allocate(1 + body_length)
				.order(ByteOrder.LITTLE_ENDIAN)
				.put(block_id);
		payloadPutTo(body);
		return new nl.rdrost.rgbw.comm.layer1.Command(
				(byte)0xff,	this.command_id.value, body.flip());
	}
}
