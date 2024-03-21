package nl.rdrost.rgbw.comm.layer2;

import java.nio.ByteBuffer;
import java.util.Objects;

public abstract class AbstractCommand {
	private nl.rdrost.rgbw.comm.layer1.Command command = null;
	protected final CommandId                  command_id;
	
	public AbstractCommand(final CommandId command_id) {
		Objects.nonNull(command_id);
		this.command_id = command_id;
	}
	
	public final CommandId getCommandId() {
		return this.command_id;
	}
	
	public synchronized final nl.rdrost.rgbw.comm.layer1.Command asCommand() {
		if (Objects.isNull(command)) {
			command = createCommand();
		}
		return command;
	}
	
	protected abstract int        getPayloadLength();
	protected abstract void       payloadPutTo(final ByteBuffer payload);
	protected abstract nl.rdrost.rgbw.comm.layer1.Command createCommand();
}
