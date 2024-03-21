package nl.rdrost.rgbw.comm.layer3;

import java.nio.ByteBuffer;
import java.util.Objects;

import nl.rdrost.rgbw.comm.layer2.AbstractCommand;
import nl.rdrost.rgbw.comm.layer2.BroadcastCommand;
import nl.rdrost.rgbw.comm.layer2.CommandId;
import nl.rdrost.rgbw.types.LightControlModes;

public class LightControlModesCommand extends BroadcastCommand {
	private final LightControlModes modes;
	
	public LightControlModesCommand(final LightControlModes modes) {
		super(INFO);
		
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
	
	public static BroadcastCommand.Info INFO = new BroadcastCommand.Info() {
		
		@Override
		public CommandId getCommand_id() {
			return CommandId.LIGHT_CONTROLLER_MODES;
		}
		
		@Override
		protected AbstractCommand commandFrom(final ByteBuffer payload) {
			return new LightControlModesCommand(
					LightControlModes.fromByte(payload.get()));
		}
	};
}
