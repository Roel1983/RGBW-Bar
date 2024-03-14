#include "../bootloader.hpp"
#include "../lightControl.hpp"
#include "../utils.hpp"
#include "receiver/command_info.hpp"

#include "communication.hpp"
#include "commands.hpp"

using namespace communication;

namespace communication {

PRIVATE COMMAND_INFO_DECL const receiver::CommandInfo* command_infos[] = {
	&request_to_send_command_info,
	nullptr,
	&lightControl::light_control_command_info,
	&bootloader::bootloader_command_info,
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
