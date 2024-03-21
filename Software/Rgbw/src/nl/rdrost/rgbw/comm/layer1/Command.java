package nl.rdrost.rgbw.comm.layer1;

import java.nio.ByteBuffer;

public class Command {
	final byte       sender_unique_id;
	final byte       command_id;
	final ByteBuffer body;
	
	public Command(
		byte             sender_unique_id,
		final byte       command_id,
		final ByteBuffer body
	) {
		this.sender_unique_id = sender_unique_id;
		this.command_id       = command_id;
		this.body             = body.asReadOnlyBuffer();
	}
	
	public final byte getSender_unique_id() {
		return this.sender_unique_id;
	}
	
	public final byte getCommand_id() {
		return this.command_id;
	}
	
	public final ByteBuffer getBody() {
		return this.body.duplicate();
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Command [sender_unique_id=").append(sender_unique_id);
		builder.append(", command_id=").append(command_id);
		builder.append(", body=");
		ByteBuffer tmp_body = this.body.duplicate();
		while (tmp_body.hasRemaining()) {
			builder.append(String.format("<%02X>", tmp_body.get()));
		}
		builder.append("]");
		return builder.toString();
	}
	
	
}
