package nl.rdrost.rgbw.ledbar;

import java.nio.ByteBuffer;
import java.util.Objects;

import nl.rdrost.rgbw.types.Rgbw;

public class BasicSettings extends AbstractSettings<BasicSettings> {
	public static final int PAYLOAD_SIZE = 25;
	
	public static final Rgbw DEFAULT_WORK_LIGHT_COLOR = new Rgbw(new short[] {1500, 1500, 1500, 3000});
	public static final Rgbw DEFAULT_FLUT_LIGHT_COLOR = new Rgbw(new short[] {4094, 4094, 4094, 4094});
	
	public static class Builder {
		private static final int UNSET_ID = -1;
		
		private int device_id = 0;
		private int group_id  = 0;
		private int sun_id    = UNSET_ID;
		private int strip_id  = UNSET_ID;
		
		private Rgbw work_light_color = DEFAULT_WORK_LIGHT_COLOR;
		private Rgbw flut_light_color = DEFAULT_FLUT_LIGHT_COLOR;
		
		private boolean strip_reverse = false;
		
		public Builder setDeviceId(int id) {
			if (id < 0 && id > 0xFE) {
				throw new IllegalArgumentException();
			}
			this.device_id = id;
			return this;
		}
		
		public Builder setGroupId(int id) {
			if (id < 0 && id > 0xFF) {
				throw new IllegalArgumentException();
			}
			this.group_id = id;
			return this;
		}
		
		public Builder setSunId(int id) {
			if (id < 0 && id > 0xFF) {
				throw new IllegalArgumentException();
			}
			this.sun_id = id;
			return this;
		}
		
		public Builder setStripId(int id) {
			if (id < 0 && id > 0xFF) {
				throw new IllegalArgumentException();
			}
			this.strip_id = id;
			return this;
		}
		
		public Builder setWorkLightColor(final Rgbw color) {
			Objects.nonNull(color);
			this.work_light_color = color;
			return this;
		}
		
		public Builder setFlutLightColor(final Rgbw color) {
			Objects.nonNull(color);
			this.flut_light_color = color;
			return this;
		}
		
		public Builder setStripReverse(final boolean value) {
			this.strip_reverse = value;
			return this;
		}
		
		public BasicSettings build() {
			final int sun_id    = this.sun_id   != UNSET_ID ? this.sun_id   : this.device_id;
			final int strip_id  = this.strip_id != UNSET_ID ? this.strip_id : this.device_id * 4;
			return new BasicSettings(
					this.device_id,
					this.group_id,
					sun_id,
					strip_id,
					this.work_light_color,
					this.flut_light_color,
					this.strip_reverse);
		}
	}
	
	private final int device_id;
	private final int group_id;
	private final int sun_id;
	private final int strip_id;
	
	private final Rgbw work_light_color;
	private final Rgbw flut_light_color;
	
	private final boolean strip_reverse;
	
	private BasicSettings(int device_id, int group_id, int sun_id, int strip_id, 
			Rgbw work_light_color, Rgbw flut_light_color, boolean strip_reverse
	) {
		this.device_id = device_id;
		this.group_id  = group_id;
		this.sun_id    = sun_id;
		this.strip_id  = strip_id;
		this.work_light_color = work_light_color;
		this.flut_light_color = flut_light_color;
		this.strip_reverse = strip_reverse;
	}
	
	public final int getDeviceId() {
		return this.device_id;
	}
	
	public final int getGroupId() {
		return this.group_id;
	}
	
	public final int getSunId() {
		return this.sun_id;
	}
	
	public final int getStripId() {
		return this.strip_id;
	}
	
	public final Rgbw getWorkLightColor() {
		return this.work_light_color;
	}
	
	public final Rgbw getFlutLightColor() {
		return this.flut_light_color;
	}

	@Override
	public String toString() {
		StringBuilder builder2 = new StringBuilder();
		builder2.append("BasicSettings [device_id=").append(device_id).append(", group_id=").append(group_id)
				.append(", sun_id=").append(sun_id).append(", strip_id=").append(strip_id).append(", work_light_color=")
				.append(work_light_color).append(", flut_light_color=").append(flut_light_color)
				.append(", strip_reverse=").append(strip_reverse).append("]");
		return builder2.toString();
	}
	
	@Override
	protected void putBodyTo(final ByteBuffer byte_buffer) {
		byte_buffer.put((byte)this.device_id);
		byte_buffer.put((byte)this.group_id);
		byte_buffer.put((byte)this.sun_id);
		byte_buffer.put((byte)this.strip_id);
		this.work_light_color.putTo(byte_buffer);
		this.flut_light_color.putTo(byte_buffer);
		final byte flags = this.strip_reverse ? (byte)0b1 : 0;
		byte_buffer.put(flags);
	}
	
	public static final Parser<BasicSettings> PARSER = new Parser<>() {
		@Override
		protected BasicSettings getBodyFrom(ByteBuffer byte_buffer) {
			final Builder builder = new Builder();
			builder.setDeviceId(byte_buffer.get());
			builder.setGroupId(byte_buffer.get());
			builder.setSunId(byte_buffer.get());
			builder.setStripId(byte_buffer.get());
			builder.setWorkLightColor(Rgbw.getFrom(byte_buffer));
			builder.setFlutLightColor(Rgbw.getFrom(byte_buffer));
			final byte    flags         = byte_buffer.get();
			final boolean strip_reverse = (flags & 0b1) != 0; 
			builder.setStripReverse(strip_reverse);
			return builder.build();
		}
	};
}
