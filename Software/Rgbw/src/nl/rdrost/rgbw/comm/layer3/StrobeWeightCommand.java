package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layer2.AbstractCommand;
import nl.rdrost.rgbw.comm.layer2.BroadcastCommand;
import nl.rdrost.rgbw.comm.layer2.CommandId;
import nl.rdrost.rgbw.comm.layer2.StripCommand;

public class StrobeWeightCommand extends StripCommand {
	public static final CommandId COMMAND_ID = CommandId.STROBE_WEIGHT;
	
	private final List<Float> weights;
	
	protected StrobeWeightCommand(final int strip_id, final float weight) {
		this(strip_id, Arrays.asList(weight));
	}
	
	protected StrobeWeightCommand(final int strip_id, final List<Float> weights) {
		super(INFO, strip_id);
		Objects.nonNull(weights);
		
		assert(weights.stream().allMatch((Float f)->!Objects.isNull(f) && f >= 0 && f <= 8192));
		
		this.weights = Collections.unmodifiableList(new ArrayList<>(weights));
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
