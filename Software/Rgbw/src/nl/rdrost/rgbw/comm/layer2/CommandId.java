package nl.rdrost.rgbw.comm.layer2;

import java.util.Optional;

import nl.rdrost.rgbw.comm.layer3.BootloaderCommand;
import nl.rdrost.rgbw.comm.layer3.LightControlModesCommand;
import nl.rdrost.rgbw.comm.layer3.RequestToSendCommand;
import nl.rdrost.rgbw.comm.layer3.SettingsReadCommand;
import nl.rdrost.rgbw.comm.layer3.SettingsWriteCommand;
import nl.rdrost.rgbw.comm.layer3.StrobeTriggerCommand;
import nl.rdrost.rgbw.comm.layer3.StrobeWeightCommand;

public enum CommandId {
	REQUEST_TO_SEND        ((byte) 0, RequestToSendCommand.INFO),
	LIGHT_CONTROLLER_MODES ((byte) 2, LightControlModesCommand.INFO),
	BOOTLOADER             ((byte) 3, BootloaderCommand.INFO),
	//STRIP_COLOR            ((byte) 4, StripColorCommand.class),
	//STRIP_TARGET_FACTOR    ((byte) 5, StripTargetFactor.class),
	STROBE_TRIGGER         ((byte) 6, StrobeTriggerCommand.INFO),
	//STROBE_COLOR           ((byte) 7, StrobeColorCommand.class),
	STROBE_WEIGHT          ((byte) 8, StrobeWeightCommand.INFO),
	SETTINGS_READ          ((byte) 9, SettingsReadCommand.INFO),
	SETTINGS_WRITE         ((byte)11, SettingsWriteCommand.INFO);
	
	public final byte                 value;
	public       AbstractCommand.Info info;
	
	private CommandId(
			final byte value,
			final AbstractCommand.Info info
	) {
		this.value = value;
		this.info  = info;
	}
	
	public static Optional<CommandId> fromValue(byte value) {
		for (CommandId command_id : CommandId.values()) {
			if (command_id.value == value) {
				return Optional.of(command_id);
			}
		}
		return Optional.empty();
	}
}
