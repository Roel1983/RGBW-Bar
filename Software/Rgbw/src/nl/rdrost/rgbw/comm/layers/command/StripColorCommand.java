package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.StripCommand;
import nl.rdrost.rgbw.types.Rgbw;

public class StripColorCommand extends StripCommand {
	
	private final List<Rgbw> colors;
	
	public StripColorCommand(final int strip_id, final Rgbw color) {
		this(strip_id, Arrays.asList(color));
	}
	
	public StripColorCommand(final int strip_id, final List<Rgbw> colors) {
		super(INFO, strip_id);
		Objects.nonNull(colors);
		
		assert(colors.stream().allMatch((Rgbw c)->!Objects.isNull(c)));
		
		this.colors = Collections.unmodifiableList(new ArrayList<>(colors));
	}
	
	public final List<Rgbw> getColors() {
		return this.colors;
	}

	@Override
	protected int getPayloadLength() {
		return this.colors.size() * Rgbw.PAYLOAD_SIZE;
	}

	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		for (final Rgbw color : this.colors) {
			color.putTo(payload);
		}
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("StripColorCommand [sender_unique_id=").append(getSenderUniqueId())
				.append(", colors=");
		
		boolean is_first = true;
		for (final Rgbw color : this.colors) {
			if (is_first) {
				is_first = false;
			} else {
				builder.append(", ");
			}
			builder.append(color);
		}
		builder.append("]");
		return builder.toString();
	}
	
	public static StripCommand.Info INFO = new StripCommand.Info() {
		@Override
		public CommandId getCommand_id() {
			return CommandId.STRIP_COLOR;
		}
		@Override
		protected AbstractCommand commandFrom(byte block_id, ByteBuffer payload) {
			// TODO Auto-generated method stub
			return null;
		}
	};
}
