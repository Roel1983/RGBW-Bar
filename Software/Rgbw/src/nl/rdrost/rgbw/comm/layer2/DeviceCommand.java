package nl.rdrost.rgbw.comm.layer2;

public abstract class DeviceCommand extends AddressableCommand {

	protected DeviceCommand(final CommandId command_id, final int device_id) {
		super(command_id, device_id);
	}
	
	public final int getDeviceId() {
		return getBlockId();
	}
}
