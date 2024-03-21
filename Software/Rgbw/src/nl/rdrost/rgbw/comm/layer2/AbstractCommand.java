package nl.rdrost.rgbw.comm.layer2;

import java.nio.ByteBuffer;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layer1.Command;

public abstract class AbstractCommand {
	private nl.rdrost.rgbw.comm.layer1.Command command = null;
	protected Info                       info;
	
	public AbstractCommand(final Info info) {
		Objects.nonNull(info);
		this.info = info;
	}
	
	public final Info getInfo() {
		return this.info;
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
	
	public static abstract class Info {
		
		public enum Type {
			BROADCAST,
			UNIQUE_ID,
			GROUP,
			DEVICE,
			SUN,
			STRIP
		}
		
		private final Type type;
		
		protected Info(final Type type) {
			this.type = type;
		}
		
		public final Type getType() {
			return this.type;
		}
		
		public abstract CommandId getCommand_id();

		protected abstract AbstractCommand commandFrom(final Command layer1_command);
	}
}
