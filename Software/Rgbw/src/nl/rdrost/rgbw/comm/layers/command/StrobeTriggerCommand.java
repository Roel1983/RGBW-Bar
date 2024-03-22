package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;
import java.time.Duration;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.BroadcastCommand;

public class StrobeTriggerCommand extends BroadcastCommand {
	public static final Duration MAX_DURATION = Duration.ofMillis(0xFFFF);
	public static final int      MAX_COUNT    = 0xFF;
	
	private final Duration on;
	private final Duration off;
	private final int      count;
	
	public StrobeTriggerCommand(final Duration on, final Duration off, final int count) {
		super(INFO);
		Objects.nonNull(on);
		Objects.nonNull(off);
		
		assert(!on.isNegative()  && !on.isZero()  && on.compareTo(MAX_DURATION)  <= 0);
		assert(!off.isNegative() && !off.isZero() && off.compareTo(MAX_DURATION) <= 0);
		assert(count <= MAX_COUNT);
		
		this.on    = on;
		this.off   = off;
		this.count = count;
	}
	
	public final Duration getOn() {
		return this.on;
	}
	
	public final Duration getOff() {
		return this.off;
	}
	
	public final int getCount() {
		return this.count;
	}
	
	@Override
	protected int getPayloadLength() {
		return 5;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("StrobeTriggerCommand [sender_unique_id=").append(getSenderUniqueId())
				.append(", on=").append(on)
				.append(", off=").append(off)
				.append(", count=").append(count)
				.append("]");
		return builder.toString();
	}

	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		payload
			.putShort((short)this.on.toMillis())
			.putShort((short)this.off.toMillis())
			.put((byte)this.count);
	}
	
	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		@Override
		public CommandId getCommand_id() {
			return CommandId.STROBE_TRIGGER;
		}
		
		@Override
		protected AbstractCommand commandFrom(ByteBuffer payload) {
			return new StrobeTriggerCommand(
					Duration.ofMillis(payload.getShort()),
					Duration.ofMillis(payload.getShort()),
					payload.get());
		}
	};
}
