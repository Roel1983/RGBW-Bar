package nl.rdrost.rgbw.comm.layer2;

public abstract class StripCommand extends AddressableCommand {

	protected StripCommand(final CommandId command_id, final int strip_id) {
		super(command_id, strip_id);
	}
	
	public final int getStripId() {
		return getBlockId();
	}
}
