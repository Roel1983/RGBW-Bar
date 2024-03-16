#include <avr/interrupt.h>

#include <string.h>

#include <avr/eeprom.h>

#include "jumpers.hpp"
#include "utils.hpp"
#include "communication/communication.hpp"

#include "settings.hpp"

namespace settings {
	
struct ReadCommand;
struct WriteCommand;

PRIVATE Settings EEMEM non_volatile_settings;
PRIVATE Settings       sram_settings;

PRIVATE void     loadSettings       (Settings& settings);
PRIVATE void     loadDefaultSettings(Settings& settings);
PRIVATE void     saveSettings       (Settings& settings);
PRIVATE bool     checkCrc           (const Settings& settings);
PRIVATE uint32_t calculateCrc       (const Settings& settings);
PRIVATE uint32_t calculateCrc       (const uint8_t *buffer, uint8_t size);
PRIVATE void     applySettings      (Settings& settings);

bool onReadCommand(const ReadCommand& command);
bool onWriteCommand(const WriteCommand& command);

void setup() {
	loadSettings(sram_settings);
	if (!checkCrc(sram_settings)) {
		loadDefaultSettings(sram_settings);
		sram_settings.crc = calculateCrc(sram_settings);
	}
	applySettings(sram_settings);
}

PRIVATE void loadDefaultSettings(Settings& settings) {
	static constexpr Color WORK_LIGHT_COLOR = {1500, 1500, 1500, 3000};
	memcpy(&settings.work_light_color[0], &WORK_LIGHT_COLOR[0], sizeof(Color));
	
	static constexpr Color FLUT_LIGHT_COLOR = {4094, 4094, 4094, 4094};
	memcpy(&settings.flut_light_color[0], &FLUT_LIGHT_COLOR[0], sizeof(Color));
	
	settings.unique_id = 0;
	for (int i = 0; i < 4; i++) {
		settings.unique_id <<= 1;
		settings.unique_id |= (jumpers::get(3 - i) ? 1 : 0);
	}
	
	settings.device_id = settings.unique_id;
	settings.group_id  = 0;
	settings.sun_id    = settings.device_id;
	settings.strip_id  = settings.device_id * 4;	
}

PRIVATE void applySettings(Settings& settings) {
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_UNIQUE_ID, settings.unique_id);
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_DEVICE,    settings.device_id);
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_GROUP,     settings.group_id);
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_SUN,       settings.sun_id);
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_STRIP,     settings.strip_id);
}

PRIVATE void loadSettings(Settings& settings) {
	cli();
	eeprom_read_block(&settings, &non_volatile_settings, sizeof(settings));
	sei();
}

PRIVATE void saveSettings(Settings& settings) {
	sram_settings.crc = calculateCrc(sram_settings);
	cli();
	eeprom_write_block(&settings, &non_volatile_settings, sizeof(settings));
	sei();
}

PRIVATE bool checkCrc(const Settings& settings) {
	return (sram_settings.crc == calculateCrc(settings));
}

PRIVATE uint32_t calculateCrc(const Settings& settings) {
	return calculateCrc(
		reinterpret_cast<const uint8_t*>(&settings) + sizeof(settings.crc),
		sizeof(settings) - sizeof(settings.crc));
}

PRIVATE uint32_t calculateCrc(const uint8_t *buffer, uint8_t size) {
	constexpr uint32_t prime = 31;
	uint32_t res = 1;
	for (int i = 0; i < size; i++) {
		res += buffer[i];
		res *= prime;
	}
	return res;
}
	
const Settings& get() {	
	return sram_settings;
}

struct ReadCommand {
	/* Empty */
};
static_assert(sizeof(ReadCommand) == 1, "");

struct ReadResponse {
	Settings settings;
};

PRIVATE communication::receiver::Command<communication::COMMAND_TYPE_UNIQUE_ID, ReadCommand> read_command;

communication::receiver::CommandInfo read_command_info(
	read_command,
	onReadCommand);

bool onReadCommand(const ReadCommand& command) {
	return communication::sendBroadcast(
		10,
		sizeof(ReadResponse),
		[](bool is_timeout, uint8_t& payload_size, uint8_t *payload_buffer) {
			if(!is_timeout) {
				memcpy(payload_buffer, &get(), payload_size);
			}
			return true;
		});
}

struct WriteCommand {
	Settings settings;
};

PRIVATE communication::receiver::Command<communication::COMMAND_TYPE_UNIQUE_ID, WriteCommand> write_command;

communication::receiver::CommandInfo write_command_info(
	write_command,
	onWriteCommand);

bool onWriteCommand(const WriteCommand& command) {
	if (checkCrc(command.settings) && 0 != memcmp(&sram_settings, &command.settings, sizeof(sram_settings))) {
		memcpy(&sram_settings, &command.settings, sizeof(sram_settings));
		saveSettings(sram_settings);
		applySettings(sram_settings);
	}
	return true;
}

} // End of: namespace settings
