package nl.rdrost.rgbw.comm.layer2;

import java.util.Optional;

public enum CommandId {
	REQUEST_TO_SEND        ((byte) 0),
	LIGHT_CONTROLLER_MODES ((byte) 2),
	BOOTLOADER             ((byte) 3),
	STRIP_COLOR            ((byte) 4),
	STRIP_TARGET_FACTOR    ((byte) 5),
	STROBE_TRIGGER         ((byte) 6),
	STROBE_COLOR           ((byte) 7),
	STROBE_WEIGHT          ((byte) 8),
	SETTINGS_READ          ((byte) 9),
	SETTINGS_WRITE         ((byte)11);
	
	public final byte value;
	
	private CommandId(byte value) {
		this.value = value;
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
