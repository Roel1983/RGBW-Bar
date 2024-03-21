package nl.rdrost.rgbw.comm.layer2;

public abstract class SunCommand extends AddressableCommand {
	
	protected SunCommand(final CommandId command_id, final int sun_id) {
		super(command_id, sun_id);
	}
	
	public final int getSunId() {
		return getBlockId();
	}
}
