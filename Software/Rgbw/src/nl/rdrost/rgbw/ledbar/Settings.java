package nl.rdrost.rgbw.ledbar;

import java.nio.ByteBuffer;
import java.util.Objects;

public class Settings {
	
	public static final int PAYLOAD_SIZE = ExpertSettings.PAYLOAD_SIZE + BasicSettings.PAYLOAD_SIZE;
	
	private final ExpertSettings expert_settings;
	private final BasicSettings  basic_settings;
	
	public Settings(final ExpertSettings expert_settings, final BasicSettings basic_settings) {
		Objects.nonNull(expert_settings);
		Objects.nonNull(basic_settings);
		
		this.expert_settings = expert_settings;
		this.basic_settings  = basic_settings;
	}

	public final ExpertSettings getExpert_settings() {
		return this.expert_settings;
	}

	public final BasicSettings getBasic_settings() {
		return this.basic_settings;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Settings [expert_settings=").append(expert_settings).append(", basic_settings=")
				.append(basic_settings).append("]");
		return builder.toString();
	}

	public final void putTo(final ByteBuffer byte_buffer) {
		this.expert_settings.putTo(byte_buffer);
		this.basic_settings.putTo(byte_buffer);
	}
	
	public static Settings getFrom(final ByteBuffer byte_buffer) {
		final ExpertSettings expert_settings = ExpertSettings.PARSER.parseFrom(byte_buffer);
		final BasicSettings  base_settings   = BasicSettings.PARSER.parseFrom(byte_buffer);
		return new Settings(expert_settings, base_settings);
	}	
}
