package nl.rdrost.rgbw.comm.layers.command.details;

public abstract class StripCommand extends AddressableCommand {

	protected StripCommand(final Info info, final int strip_id) {
		super(info, strip_id);
	}
	
	public final int getStripId() {
		return getBlockId();
	}
	
	public static abstract class Info extends AddressableCommand.Info {
		public Info() {
			super(AbstractCommand.Info.Type.STRIP);
		}
	}
}
