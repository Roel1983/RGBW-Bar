package nl.rdrost.rgbw.comm.layers.command.details;

public abstract class GroupCommand extends AddressableCommand {

	protected GroupCommand(final Info info, final int group_id) {
		super(info, group_id);
	}
	
	public final int getGroupId() {
		return getBlockId();
	}
	
	public static abstract class Info extends AddressableCommand.Info {
		public Info() {
			super(AbstractCommand.Info.Type.GROUP);
		}
	}
}
