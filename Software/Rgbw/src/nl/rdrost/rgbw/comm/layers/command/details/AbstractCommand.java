package nl.rdrost.rgbw.comm.layers.command.details;

import java.nio.ByteBuffer;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.CommandId;
import nl.rdrost.rgbw.comm.layers.packet.Command;

public abstract class AbstractCommand {
	private nl.rdrost.rgbw.comm.layers.packet.Command packet_command = null;
	protected Info                       info;
	
	public AbstractCommand(final Info info) {
		Objects.nonNull(info);
		this.info = info;
	}
	
	public final Info getInfo() {
		return this.info;
	}
	
	public synchronized final nl.rdrost.rgbw.comm.layers.packet.Command getPacketCommand() {
		if (Objects.isNull(this.packet_command)) {
			this.packet_command = createCommand();
		}
		return this.packet_command;
	}
	
	void setPacketCommand(final nl.rdrost.rgbw.comm.layers.packet.Command packet_command) {
		assert(Objects.isNull(this.packet_command));
		this.packet_command = packet_command;
	}
	
	public final int getSenderUniqueId() {
		return this.getPacketCommand().getSenderUniqueId();
	}
	
	protected abstract int        getPayloadLength();
	protected abstract void       payloadPutTo(final ByteBuffer payload);
	protected abstract nl.rdrost.rgbw.comm.layers.packet.Command createCommand();
	
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

		public abstract AbstractCommand commandFrom(final Command layer1_command);
	}
}
