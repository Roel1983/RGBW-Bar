package nl.rdrost.rgbw.comm.layer2;

public abstract class GroupCommand extends AddressableCommand {

	protected GroupCommand(final CommandId command_id, final int group_id) {
		super(command_id, group_id);
	}
	
	public final int getGroupId() {
		return getBlockId();
	}
}
