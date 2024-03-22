package nl.rdrost.rgbw.comm.layers.command;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;
import nl.rdrost.rgbw.comm.layers.command.details.StripCommand;

public class StrobeWeightCommand extends StripCommand {
	private final List<Float> weights;
	
	public StrobeWeightCommand(final int strip_id, final float weight) {
		this(strip_id, Arrays.asList(weight));
	}
	
	public StrobeWeightCommand(final int strip_id, final List<Float> weights) {
		super(INFO, strip_id);
		Objects.nonNull(weights);
		
		assert(weights.stream().allMatch((Float f)->!Objects.isNull(f) && f >= 0 && f <= 8192));
		
		this.weights = Collections.unmodifiableList(new ArrayList<>(weights));
	}
	
	public final List<Float> getWeights() {
		return this.weights;
	}
	
	@Override
	protected int getPayloadLength() {
		return 2 * this.weights.size();
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		for (final float weight : this.weights) {
			payload.putShort((short)(weight * 8192));
		}
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("StrobeWeightCommand [sender_unique_id=").append(getSenderUniqueId())
				.append(", strip_id=").append(getStripId())
				.append(", weights=");
		
		boolean is_first = true;
		for (final float weight : this.weights) {
			if (is_first) {
				is_first = false;
			} else {
				builder.append(", ");
			}
			builder.append(String.format("%2.1f", weight));
		}
		builder.append("]");
		return builder.toString();
	}

	public static StripCommand.Info INFO = new StripCommand.Info() {
		
		@Override
		public CommandId getCommand_id() {
			return CommandId.STROBE_WEIGHT;
		}
		
		@Override
		protected AbstractCommand commandFrom(byte block_id, ByteBuffer payload) {
			// TODO Auto-generated method stub
			return null;
		}
	};
}
