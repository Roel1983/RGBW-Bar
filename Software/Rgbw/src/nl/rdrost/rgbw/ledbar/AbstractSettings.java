package nl.rdrost.rgbw.ledbar;

import java.nio.ByteBuffer;

public abstract class AbstractSettings<S extends AbstractSettings<S>> {
	
	public final void putTo(final ByteBuffer byte_buffer) {
		int crc_position = byte_buffer.position();
		byte_buffer.position(crc_position + 4);
		
		putBodyTo(byte_buffer);
		
		final ByteBuffer body = byte_buffer.duplicate().flip().position(crc_position + 4);
		final int crc = calculateCrc(body);
		byte_buffer.putInt(crc_position, crc);
	}
	
	protected abstract void putBodyTo(ByteBuffer byte_buffer);

	public static int calculateCrc(final ByteBuffer body) {
		int crc = 0xBEAF;
		while (body.hasRemaining()) {
			 int b =  body.get() & 0xFF;
			 crc += b ;
			 crc *= 31;
		}
		return crc;
	}
	
	public static abstract class Parser<S extends AbstractSettings<S>> {
		public S parseFrom(final ByteBuffer byte_buffer) {
			final int crc            = byte_buffer.getInt();
			final int body_start_pos = byte_buffer.position();
			
			final S settings = getBodyFrom(byte_buffer);
			
			final ByteBuffer body = byte_buffer.duplicate().flip().position(body_start_pos);
			final int expected_crc = calculateCrc(body);
			if (crc != expected_crc) {
				throw new IllegalArgumentException();
			}
			return settings;
		}
		
		protected abstract S getBodyFrom(ByteBuffer byte_buffer);
	}
}
