package nl.rdrost.rgbw.comm.layers.command.details;

public abstract class DeviceCommand extends AddressableCommand {

	protected DeviceCommand(final Info info, final int device_id) {
		super(info, device_id);
	}
	
	public final int getDeviceId() {
		return getBlockId();
	}
	
	public static abstract class Info extends AddressableCommand.Info {
		public Info() {
			super(AbstractCommand.Info.Type.DEVICE);
		}
	}
}
