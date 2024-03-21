package nl.rdrost.rgbw.comm.layer2;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

public abstract class BroadcastCommand extends AbstractCommand {
	
	protected BroadcastCommand(final CommandId command_id) {
		super(command_id);
	}
	
	@Override
	protected nl.rdrost.rgbw.comm.layer1.Command createCommand() {
		final int body_length = getPayloadLength();
		assert(body_length >= 0 && body_length < 0x8fff);
		final ByteBuffer body = ByteBuffer.allocate(body_length)
				.order(ByteOrder.LITTLE_ENDIAN);
		payloadPutTo(body);
		return new nl.rdrost.rgbw.comm.layer1.Command(
				(byte)0xff,	this.command_id.value, body.flip());
	}
}
