#include <util/delay.h> 

#include "../bootloader.hpp"
#include "../lightControl.hpp"
#include "../utils.hpp"
#include "receiver/command_info.hpp"

#include "communication.hpp"
#include "commands.hpp"

using namespace communication;

namespace communication {

struct BootloadCommand {
	uint8_t unique_id;
	uint8_t seconds_timeout;
};
communication::receiver::Command<COMMAND_TYPE_BROADCAST, BootloadCommand> bootload_command;
bool onBootloadCommand(const BootloadCommand& payload) {
	if (commandTypeGetBlockNr(COMMAND_TYPE_UNIQUE_ID) == payload.unique_id) {
		_delay_ms(3000);
		bootloader::execute();
	} else {
		communication::ignoreBootloader(payload.seconds_timeout * 1000);
	}
	return true;
};
communication::receiver::CommandInfo bootload_command_info(
	bootload_command,
	onBootloadCommand);

PRIVATE COMMAND_INFO_DECL const receiver::CommandInfo* command_infos[] = {
	&request_to_send_command_info,
	nullptr,
	&lightControl::light_control_command_info,
	&bootload_command_info,
};

const receiver::CommandInfo * const getCommandInfo(const uint8_t command_id) {
	if (command_id >= GetArrLength(command_infos)) {
		return nullptr;
	}
	return command_infos[command_id];
}

uint8_t getCommandInfoCount() {
	return GetArrLength(command_infos);
}

} // End of: namespace communication
