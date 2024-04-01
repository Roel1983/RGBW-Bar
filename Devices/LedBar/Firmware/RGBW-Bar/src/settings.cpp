#include <avr/interrupt.h>

#include <string.h>

#include <avr/eeprom.h>

#include "jumpers.hpp"
#include "utils.hpp"
#include "communication/communication.hpp"

#include "settings.hpp"

namespace settings {
	
struct ReadCommand;
struct WriteBasicCommand;
struct WriteExpertCommand;

PRIVATE ExpertSettings       expert_settings;
PRIVATE ExpertSettings EEMEM expert_settings_non_volatile;
PRIVATE BasicSettings        basic_settings;
PRIVATE BasicSettings EEMEM  basic_settings_non_volatile;

PRIVATE void     loadSettings             ();
PRIVATE void     loadDefaultExpertSettings();
PRIVATE void     loadDefaultBasicSettings ();
PRIVATE void     saveExpertSettings       ();
PRIVATE void     saveBasicSettings        ();
PRIVATE bool     checkCrc                 (const ExpertSettings& settings);
PRIVATE bool     checkCrc                 (const BasicSettings& settings);
PRIVATE int32_t  calculateCrc             (const ExpertSettings& settings);
PRIVATE int32_t  calculateCrc             (const BasicSettings& settings);
PRIVATE int32_t  calculateCrc             (const uint8_t *buffer, uint8_t size);
PRIVATE void     applyExpertSettings      ();
PRIVATE void     applyBasicSettings       ();

bool onReadCommand       (const ReadCommand& command);
bool onWriteExpertCommand(const WriteExpertCommand& command);
bool onWriteBasicCommand (const WriteBasicCommand& command);

void setup() {
	loadSettings();
	
	if (!checkCrc(expert_settings)) {
		loadDefaultExpertSettings();
		expert_settings.crc = calculateCrc(expert_settings);
	}
	applyExpertSettings();
	
	if (!checkCrc(basic_settings)) {
		loadDefaultBasicSettings();
		basic_settings.crc = calculateCrc(basic_settings);
	}
	applyBasicSettings();
}

PRIVATE void loadSettings() {
	cli();
	eeprom_read_block(&expert_settings, &expert_settings_non_volatile, sizeof(expert_settings));
	eeprom_read_block(&basic_settings,  &basic_settings_non_volatile,  sizeof(basic_settings));
	sei();
}

PRIVATE void loadDefaultExpertSettings() {
	expert_settings.unique_id = 0;
	for (int i = 0; i < 4; i++) {
		expert_settings.unique_id <<= 1;
		expert_settings.unique_id |= (jumpers::get(3 - i) ? 1 : 0);
	}
}

PRIVATE void loadDefaultBasicSettings() {
	static constexpr Color WORK_LIGHT_COLOR = {1500, 1500, 1500, 3000};
	memcpy(&basic_settings.work_light_color[0], &WORK_LIGHT_COLOR[0], sizeof(Color));
	
	static constexpr Color FLUT_LIGHT_COLOR = {4094, 4094, 4094, 4094};
	memcpy(&basic_settings.flut_light_color[0], &FLUT_LIGHT_COLOR[0], sizeof(Color));
	
	basic_settings.device_id = expert_settings.unique_id;
	basic_settings.group_id  = 0;
	basic_settings.sun_id    = basic_settings.device_id;
	basic_settings.strip_id  = basic_settings.device_id * 4;	
}

PRIVATE void applyExpertSettings() {
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_UNIQUE_ID, expert_settings.unique_id);
}

PRIVATE void applyBasicSettings() {
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_DEVICE,    basic_settings.device_id);
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_GROUP,     basic_settings.group_id);
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_SUN,       basic_settings.sun_id);
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_STRIP,     basic_settings.strip_id);
}

PRIVATE void saveBasicSettings() {
	basic_settings.crc = calculateCrc(basic_settings);
	cli();
	eeprom_write_block(&basic_settings, &basic_settings_non_volatile, sizeof(basic_settings));
	sei();
}

PRIVATE void saveExpertSettings() {
	expert_settings.crc = calculateCrc(expert_settings);
	cli();
	eeprom_write_block(&expert_settings, &expert_settings_non_volatile, sizeof(expert_settings));
	sei();
}

PRIVATE bool checkCrc(const BasicSettings& settings) {
	return (settings.crc == calculateCrc(settings));
}

PRIVATE bool checkCrc(const ExpertSettings& settings) {
	return (settings.crc == calculateCrc(settings));
}

PRIVATE int32_t calculateCrc(const BasicSettings& settings) {
	return calculateCrc(
		reinterpret_cast<const uint8_t*>(&settings) + sizeof(settings.crc),
		sizeof(settings) - sizeof(settings.crc));
}

PRIVATE int32_t calculateCrc(const ExpertSettings& settings) {
	return calculateCrc(
		reinterpret_cast<const uint8_t*>(&settings) + sizeof(settings.crc),
		sizeof(settings) - sizeof(settings.crc));
}

PRIVATE int32_t calculateCrc(const uint8_t *buffer, uint8_t size) {
	constexpr int32_t prime = 31;
	int32_t res = 0xBEAF;
	for (int i = 0; i < size; i++) {
		res += buffer[i];
		res *= prime;
	}
	return res;
}
	
const BasicSettings& getBasic() {	
	return basic_settings;
}

const BasicSettings& getExpert() {	
	return basic_settings;
}

struct ReadCommand {
	uint8_t settings_type;
};
static_assert(sizeof(ReadCommand) == 1, "");

struct ReadBasicResponse {
	BasicSettings settings;
};

struct ReadExpertResponse {
	ExpertSettings settings;
};

PRIVATE communication::receiver::Command<communication::COMMAND_TYPE_UNIQUE_ID, ReadCommand> read_command;

communication::receiver::CommandInfo read_command_info(
	read_command,
	onReadCommand);

bool onReadCommand(const ReadCommand& command) {
	switch (command.settings_type) {
	case 0: // Basic
		return communication::sendBroadcast(
			10,
			sizeof(ReadBasicResponse),
			[](bool is_timeout, uint8_t& payload_size, uint8_t *payload_buffer) {
				if(!is_timeout) {
					memcpy(payload_buffer, &getBasic(), payload_size);
				}
				return true;
			});
	case 1: // Expert
		return communication::sendBroadcast(
			14, 
			sizeof(ReadExpertResponse),
			[](bool is_timeout, uint8_t& payload_size, uint8_t *payload_buffer) {
				if(!is_timeout) {
					memcpy(payload_buffer, &getExpert(), payload_size);
				}
				return true;
			});
	default:
		// Invalid settings_type
		return true;
	}
}

struct WriteBasicCommand {
	BasicSettings settings;
};

PRIVATE communication::receiver::Command<communication::COMMAND_TYPE_UNIQUE_ID, WriteBasicCommand> write_basic_command;

communication::receiver::CommandInfo write_basic_command_info(
	write_basic_command,
	onWriteBasicCommand);

bool onWriteBasicCommand(const WriteBasicCommand& command) {
	if (checkCrc(command.settings) && 0 != memcmp(&basic_settings, &command.settings, sizeof(basic_settings))) {
		memcpy(&basic_settings, &command.settings, sizeof(basic_settings));
		saveBasicSettings();
		applyBasicSettings();
	}
	return true;
}

struct WriteExpertCommand {
	ExpertSettings settings;
};

PRIVATE communication::receiver::Command<communication::COMMAND_TYPE_UNIQUE_ID, WriteExpertCommand> write_expert_command;

communication::receiver::CommandInfo write_expert_command_info(
	write_expert_command,
	onWriteExpertCommand);

bool onWriteExpertCommand(const WriteExpertCommand& command) {
	if (checkCrc(command.settings) && 0 != memcmp(&expert_settings, &command.settings, sizeof(expert_settings))) {
		memcpy(&expert_settings, &command.settings, sizeof(expert_settings));
		saveExpertSettings();
		applyExpertSettings();
	}
	return true;
}

} // End of: namespace settings
