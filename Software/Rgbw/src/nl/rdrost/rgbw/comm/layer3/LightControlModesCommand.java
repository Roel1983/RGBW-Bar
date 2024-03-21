package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layer2.BroadcastCommand;
import nl.rdrost.rgbw.comm.layer2.CommandId;
import nl.rdrost.rgbw.types.LightControlModes;

public class LightControlModesCommand extends BroadcastCommand {
	public static final CommandId COMMAND_ID = CommandId.LIGHT_CONTROLLER_MODES;
	
	
	
	private final LightControlModes modes;
	
	public LightControlModesCommand(final LightControlModes modes) {
		super(COMMAND_ID);
		
		Objects.nonNull(modes);
		
		this.modes = modes;
	}
	
	@Override
	protected int getPayloadLength() {
		return 1;
	}
	
	@Override
	protected void payloadPutTo(final ByteBuffer payload) {
		payload.put(modes.asByte());
		
	}
}
