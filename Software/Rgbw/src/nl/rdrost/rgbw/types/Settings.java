package nl.rdrost.rgbw.types;

import java.nio.ByteBuffer;
import java.util.Objects;

public class Settings {
	public  static final int PAYLOAD_SIZE = 9 + 2 * Rgbw.PAYLOAD_SIZE;
	private static final int CRC_PRIME = 31;
	
	private final byte unique_id;
	private final byte device_id;
	private final byte group_id;
	private final byte sun_id;
	private final byte strip_id;
	private final Rgbw work_light_color;
	private final Rgbw flut_light_color;
	
	public Settings(final byte unique_id, final byte device_id, final byte group_id, final byte sun_id, 
			final byte strip_id, final Rgbw work_light_color, final Rgbw flut_light_color
	) {
		Objects.nonNull(work_light_color);
		Objects.nonNull(flut_light_color);
		
		this.unique_id = unique_id;
		this.device_id = device_id;
		this.group_id  = group_id;
		this.sun_id    = sun_id;
		this.strip_id  = strip_id;
		this.work_light_color = work_light_color;
		this.flut_light_color = flut_light_color;
	}
	
	// TODO getters

	public void putTo(final ByteBuffer payload) {
		
		int crc_position = payload.position();
		payload.position(crc_position + 4);
		payload.put(this.unique_id);
		payload.put(this.device_id);
		payload.put(this.group_id);
		payload.put(this.sun_id);
		payload.put(this.strip_id);
		
		this.work_light_color.putTo(payload);
		this.flut_light_color.putTo(payload);
		
		ByteBuffer bb = payload.duplicate().flip().position(crc_position + 4);
		int crc = 1;
		while (bb.hasRemaining()) {
			 crc += bb.get();
			 crc *= CRC_PRIME;
		}
		payload.putInt(crc_position, crc);
	}
}