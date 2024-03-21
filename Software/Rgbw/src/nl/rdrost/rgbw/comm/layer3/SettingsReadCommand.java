package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;

import nl.rdrost.rgbw.comm.layer2.CommandId;
import nl.rdrost.rgbw.comm.layer2.UniqueIdCommand;

public class SettingsReadCommand extends UniqueIdCommand {
	public static final CommandId COMMAND_ID = CommandId.SETTINGS_READ;
	
	private final int count;
	
	public SettingsReadCommand(final int unique_id) {
		this(unique_id, 1);
	}
	
	public SettingsReadCommand(final int unique_id, final int count) {
		super(COMMAND_ID, unique_id);
		
		assert(count > 0 && unique_id + count < 0xff);
		
		this.count = count;
	}
	
	public final int getCount() {
		return this.count;
	}
	
	@Override
	protected int getPayloadLength() {
		return this.count;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		for (int i = 0; i < this.count; i++) {
			payload.put((byte)0x00);
		}
	}
}
