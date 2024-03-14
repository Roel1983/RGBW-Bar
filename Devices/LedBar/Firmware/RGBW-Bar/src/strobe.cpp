#include "strobe.hpp"

namespace strobe {

using timestamp::Timestamp;

struct TriggerCommand;
struct StripColorCommand;
struct StripWeightCommand;
	
static Timestamp     strobe_on;
static Timestamp     strobe_off;
static uint8_t       strobe_count=0;
static bool          strobe_toggle;
static Timestamp     strobe_next_change;
static Color         strobe_colors[4]  = {{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094}};
static Factor        strobe_strip_weight[4] = {FACTOR_MAX, FACTOR_MAX, FACTOR_MAX, FACTOR_MAX};

static bool onTriggerCommand(const TriggerCommand& command);
static bool onStripColorCommand(uint8_t relative_block_nr, const StripColorCommand& command);
static bool onStripWeightCommand(uint8_t relative_block_nr, const StripWeightCommand& command);

void trigger(Timestamp on, Timestamp off, uint8_t count) {
	strobe_on          = on;
	strobe_off         = off;
	strobe_count       = count;
	strobe_toggle      = false;
	strobe_next_change = timestamp::getMsTimestamp();
}

Factor getStripFactor(int index) {
	if (strobe_count == 0) {
		return 0;
	}
	Timestamp timestamp = timestamp::getMsTimestamp();
	if ((long)(strobe_next_change - timestamp) <= 0) {
		strobe_toggle = !strobe_toggle;
		if (strobe_toggle) {
			strobe_next_change += strobe_on;
		} else {
			strobe_next_change += strobe_off;
			if (strobe_count != COUNT_INFINITE) {
				strobe_count--;
			}
		}
	}
	return strobe_toggle ? strobe_strip_weight[index] : 0;  
}

const Color& getStripColor(int index) {
	return strobe_colors[index];
}

void setStripColor(int index, const Color& color) {
	strobe_colors[index][0] = color[0];
	strobe_colors[index][1] = color[1];
	strobe_colors[index][2] = color[2];
	strobe_colors[index][3] = color[3];
}

void setStripWeight(int index, Factor weight) {
	strobe_strip_weight[index] = weight;
}

struct TriggerCommand {
	uint16_t on;
	uint16_t off;
	uint8_t count;
};
static_assert(sizeof(TriggerCommand) == 5,"");

// TODO should be group
communication::receiver::Command<communication::COMMAND_TYPE_BROADCAST, TriggerCommand> trigger_command;

communication::receiver::CommandInfo trigger_command_info(
	trigger_command,
	onTriggerCommand);

static bool onTriggerCommand(const TriggerCommand& command) {
	trigger(command.on, command.off, command.count);
	return true;
} 

struct StripColorCommand {
	Color color;
};

communication::receiver::Command<communication::COMMAND_TYPE_STRIP, StripColorCommand> strip_color_command;

communication::receiver::CommandInfo strip_color_command_info(
	strip_color_command,
	onStripColorCommand);

static bool onStripColorCommand(uint8_t relative_block_nr, const StripColorCommand& command) {
	setStripColor(relative_block_nr, command.color);
	return true;
}

struct StripWeightCommand {
	Factor weight;
};

communication::receiver::Command<communication::COMMAND_TYPE_STRIP, StripWeightCommand> strip_weight_command;

communication::receiver::CommandInfo strip_weight_command_info(
	strip_weight_command,
	onStripWeightCommand);

static bool onStripWeightCommand(uint8_t relative_block_nr, const StripWeightCommand& command) {
	setStripWeight(relative_block_nr, command.weight);
	return true;
}

} // End of: namespace strobe
