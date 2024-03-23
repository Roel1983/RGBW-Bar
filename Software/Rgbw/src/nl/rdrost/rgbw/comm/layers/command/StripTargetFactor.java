package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;
import java.time.Duration;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.BroadcastCommand;

public class StripTargetFactor extends BroadcastCommand {
	public static final Duration MAX_DURATION = Duration.ofMillis(0x8FFF);
	private static final int FACTOR_MAX_SHORT = 8192;
	
	private final float    factor;
	private final Duration duration;
	
	public StripTargetFactor(final float factor, final Duration duration) {
		super(INFO);
		
		assert(factor >= 0.0f && factor <= 1.0);
		assert(!duration.isNegative()  && !duration.isZero()  && duration.compareTo(MAX_DURATION)  <= 0);
		
		this.factor   = factor;
		this.duration = duration;
	}
	
	public final float getFactor() {
		return this.factor;
	}
	
	public final Duration getDuration() {
		return this.duration;
	}
	
	@Override
	protected int getPayloadLength() {
		return 6;
	}
	
	@Override
	public String toString() {
		final StringBuilder builder = new StringBuilder();
		builder.append("StripTargetFactor [sender_unique_id=").append(getSenderUniqueId())
				.append(", factor=").append(factor)
				.append(", duration=").append(duration)
				.append("]");
		return builder.toString();
	}

	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		payload.putShort((short)(this.factor * FACTOR_MAX_SHORT));
		payload.putInt((int)this.duration.toMillis());
	}
	
	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		@Override
		public CommandId getCommand_id() {
			return CommandId.STRIP_TARGET_FACTOR;
		}
		@Override
		protected AbstractCommand commandFrom(final ByteBuffer payload) {
			final float    factor   = (short)payload.getShort() / FACTOR_MAX_SHORT;
			final Duration duration = Duration.ofMillis(payload.getShort()); 
			return new StripTargetFactor(factor, duration);
		}
	};
}
