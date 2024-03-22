package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.BroadcastCommand;

public class BootloaderCommand extends BroadcastCommand {
	private final int unique_id;
	private final int seconds;
	
	public BootloaderCommand(final int unique_id, final int seconds) {
		super(INFO);
		
		assert(unique_id >= 0 && unique_id < 0xff);
		assert(seconds >= 0   && seconds < 0xff);
		
		this.unique_id = unique_id;
		this.seconds   = seconds;
	}
	
	public final int getUniqueId() {
		return this.unique_id;
	}
	
	public final int getSeconds() {
		return this.seconds;
	}
	
	@Override
	protected int getPayloadLength() {
		return 2;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		payload
			.put((byte)this.unique_id)
			.put((byte)this.seconds);
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("BootloaderCommand [sender_unique_id=").append(getSenderUniqueId())
				.append(", unique_id=").append(unique_id)
				.append(", seconds=").append(seconds)
				.append("]");
		return builder.toString();
	}

	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		
		@Override
		public CommandId getCommand_id() {
			return CommandId.BOOTLOADER;
		}
		
		@Override
		protected AbstractCommand commandFrom(final ByteBuffer payload) {
			return new BootloaderCommand(
					payload.get(),
					payload.get());
		}
	};
}
