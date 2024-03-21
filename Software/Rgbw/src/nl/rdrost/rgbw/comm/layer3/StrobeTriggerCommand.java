package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;
import java.time.Duration;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layer2.BroadcastCommand;
import nl.rdrost.rgbw.comm.layer2.CommandId;

public class StrobeTriggerCommand extends BroadcastCommand {
	public static final CommandId COMMAND_ID = CommandId.STROBE_TRIGGER;
	
	public static final Duration MAX_DURATION = Duration.ofMillis(0xFFFF);
	public static final int      MAX_COUNT    = 0xFF;
	
	private final Duration on;
	private final Duration off;
	private final int      count;
	
	public StrobeTriggerCommand(final Duration on, final Duration off, final int count) {
		super(COMMAND_ID);
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
	protected void payloadPutTo(final ByteBuffer payload) {
		payload
			.putShort((short)this.on.toMillis())
			.putShort((short)this.off.toMillis())
			.put((byte)this.count);
	}
}
