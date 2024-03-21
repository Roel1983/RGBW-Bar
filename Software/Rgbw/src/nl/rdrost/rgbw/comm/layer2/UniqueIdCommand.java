package nl.rdrost.rgbw.comm.layer2;

public abstract class UniqueIdCommand extends AddressableCommand {

	protected UniqueIdCommand(final CommandId command_id, final int unique_id) {
		super(command_id, unique_id);
	}
	
	public final int getUniqueId() {
		return getBlockId();
	}
}