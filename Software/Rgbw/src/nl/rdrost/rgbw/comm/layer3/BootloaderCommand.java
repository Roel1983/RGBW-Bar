package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;

import nl.rdrost.rgbw.comm.layer2.AbstractCommand;
import nl.rdrost.rgbw.comm.layer2.BroadcastCommand;
import nl.rdrost.rgbw.comm.layer2.CommandId;

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
