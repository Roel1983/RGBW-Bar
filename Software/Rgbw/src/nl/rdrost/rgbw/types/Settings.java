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
	
	

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Settings [unique_id=").append(unique_id).append(", device_id=").append(device_id)
				.append(", group_id=").append(group_id).append(", sun_id=").append(sun_id).append(", strip_id=")
				.append(strip_id).append(", work_light_color=").append(work_light_color).append(", flut_light_color=")
				.append(flut_light_color).append("]");
		return builder.toString();
	}

	public static Settings from(final ByteBuffer payload) {
		final int crc = payload.getInt();
		int begin_position = payload.position();
		Settings settings = new Settings(
				payload.get(),
				payload.get(),
				payload.get(),
				payload.get(),
				payload.get(),
				Rgbw.from(payload),
				Rgbw.from(payload));
		
		ByteBuffer bb = payload.duplicate().flip().position(begin_position);
		int calculated_crc = 1;
		while (bb.hasRemaining()) {
			calculated_crc += bb.get();
			calculated_crc *= CRC_PRIME;
		}
		if(crc != calculated_crc) {
			System.err.println("Settings CRC error"); // TODO
		}
		return settings;
	}
}