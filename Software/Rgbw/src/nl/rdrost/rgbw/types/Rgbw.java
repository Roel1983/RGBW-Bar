package nl.rdrost.rgbw.types;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;
import java.util.Objects;

public class Rgbw {
	
	public static final int CHANNEL_COUNT = 4;
	public static final int CHANNEL_MAX   = 4085;
	public static final int PAYLOAD_SIZE  = CHANNEL_COUNT * 2;
	
	public static final Rgbw RED   = new Rgbw(new short[] {CHANNEL_MAX, 0, 0, 0});
	public static final Rgbw GREEN = new Rgbw(new short[] {0, CHANNEL_MAX, 0, 0});
	public static final Rgbw BLUE  = new Rgbw(new short[] {0, 0, CHANNEL_MAX, 0});
	public static final Rgbw WHITE = new Rgbw(new short[] {0, 0, 0, CHANNEL_MAX});
	
	final short[] channels;
	
	public Rgbw(final short[] channels) {
		Objects.nonNull(channels);
		assert(channels.length == CHANNEL_COUNT);
		for (final short s : channels) {
			assert(s >= 0 && s <= CHANNEL_MAX);
		}
		this.channels = Arrays.copyOf(channels, CHANNEL_COUNT);
	}

	public void putTo(final ByteBuffer payload) {
		payload.order(ByteOrder.LITTLE_ENDIAN);
		for (final short s : channels) {
			payload.putShort(s);
		}
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Rgbw [channels=").append(Arrays.toString(channels)).append("]");
		return builder.toString();
	}

	public static Rgbw from(final ByteBuffer payload) {
		final short[] channels = new short[CHANNEL_COUNT];
		for (int i = 0; i < CHANNEL_COUNT; i++) {
			channels[i] = payload.getShort();
		}		
		return new Rgbw(channels);
	}
}
