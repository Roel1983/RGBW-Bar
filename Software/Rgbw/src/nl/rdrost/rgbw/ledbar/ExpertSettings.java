package nl.rdrost.rgbw.ledbar;

import java.nio.ByteBuffer;

public class ExpertSettings extends AbstractSettings<ExpertSettings> {
	public static final int PAYLOAD_SIZE = 5;
	
	public static class Builder {
		
		private int unique_id = 0;
		
		public Builder setUniqueId(final int unique_id) {
			assert(unique_id >= 0 && unique_id < 0xFE);
			this.unique_id = unique_id;
			return this;
		}
		
		public ExpertSettings build() {
			return new ExpertSettings(this.unique_id);
		}
	}
	
	private final int unique_id;
	
	private ExpertSettings(final int unique_id) {
		this.unique_id = unique_id;
	}
	
	public final int getUniqueId() {
		return this.unique_id;
	}

	@Override
	public String toString() {
		final StringBuilder sb = new StringBuilder();
		sb.append("ExpertSettings [unique_id=").append(unique_id).append("]");
		return sb.toString();
	}
	
	@Override
	protected void putBodyTo(final ByteBuffer byte_buffer) {
		byte_buffer.put((byte)this.unique_id);
	}
	
	public static final Parser<ExpertSettings> PARSER = new Parser<>() {
		@Override
		protected ExpertSettings getBodyFrom(ByteBuffer byte_buffer) {
			Builder builder = new Builder();
			builder.setUniqueId(byte_buffer.get());
			return builder.build();
		}
	};
}
