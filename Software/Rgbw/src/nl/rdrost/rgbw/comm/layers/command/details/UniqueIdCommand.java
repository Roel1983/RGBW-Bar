package nl.rdrost.rgbw.comm.layers.command.details;

public abstract class UniqueIdCommand extends AddressableCommand {

	protected UniqueIdCommand(final Info info, final int unique_id) {
		super(info, unique_id);
	}
	
	public final int getUniqueId() {
		return getBlockId();
	}
	
	public static abstract class Info extends AddressableCommand.Info {
		public Info() {
			super(AbstractCommand.Info.Type.UNIQUE_ID);
		}
	}
}