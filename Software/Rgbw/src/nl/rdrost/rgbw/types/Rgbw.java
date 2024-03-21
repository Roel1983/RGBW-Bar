package nl.rdrost.rgbw.types;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;
import java.util.Objects;

public class Rgbw {
	public static final int CHANNEL_COUNT = 4;
	public static final int CHANNEL_MAX   = 4085;
	public static final int PAYLOAD_SIZE  = CHANNEL_COUNT * 2;
	
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
}
