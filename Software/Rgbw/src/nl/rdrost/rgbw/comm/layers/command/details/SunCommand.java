package nl.rdrost.rgbw.comm.layers.command.details;

public abstract class SunCommand extends AddressableCommand {
	
	protected SunCommand(final Info info, final int sun_id) {
		super(info, sun_id);
	}
	
	public final int getSunId() {
		return getBlockId();
	}
	
	public static abstract class Info extends AddressableCommand.Info {
		public Info() {
			super(AbstractCommand.Info.Type.SUN);
		}
	}
}
