package nl.rdrost.rgbw.comm.layers.command.details;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import nl.rdrost.rgbw.comm.layers.packet.Command;

public abstract class BroadcastCommand extends AbstractCommand {
	
	protected BroadcastCommand(final Info info) {
		super(info);
	}
	
	@Override
	protected nl.rdrost.rgbw.comm.layers.packet.Command createCommand() {
		final int body_length = getPayloadLength();
		assert(body_length >= 0 && body_length < 0x8fff);
		final ByteBuffer body = ByteBuffer.allocate(body_length)
				.order(ByteOrder.LITTLE_ENDIAN);
		payloadPutTo(body);
		return new nl.rdrost.rgbw.comm.layers.packet.Command(
				(byte)0xff,	this.info.getCommand_id().value, body.flip());
	}
	
	public static abstract class Info extends AbstractCommand.Info {
		public Info() {
			super(AbstractCommand.Info.Type.BROADCAST);
		}
		
		@Override
		public final AbstractCommand commandFrom(final Command packet_command) {
			final ByteBuffer body = packet_command.getBody();
			
			final ByteBuffer      payload = body;
			final AbstractCommand command = commandFrom(payload);
			command.setPacketCommand(packet_command);
			return command;
		}
		
		protected abstract AbstractCommand commandFrom(final ByteBuffer payload);
	}
}
