#include <util/delay.h> 

#include "bootloader.hpp"

#ifndef BOOT_LOADER_ADDRESS
#define BOOT_LOADER_ADDRESS 0x7800
#endif

namespace bootloader {

void execute() {
  typedef void (*BootLoaderMeth)(void);
  ((BootLoaderMeth)BOOT_LOADER_ADDRESS)();
}

struct BootloaderCommand {
	uint8_t unique_id;
	uint8_t seconds_timeout;
};

communication::receiver::Command<communication::COMMAND_TYPE_BROADCAST, BootloaderCommand> bootloader_command;

bool onBootloaderCommand(const BootloaderCommand& payload) {
	if (commandTypeGetBlockNr(communication::COMMAND_TYPE_UNIQUE_ID) == payload.unique_id) {
		_delay_ms(3000);
		bootloader::execute();
	} else {
		communication::ignoreBootloader(payload.seconds_timeout * 1000);
	}
	return true;
};
communication::receiver::CommandInfo bootloader_command_info(
	bootloader_command,
	onBootloaderCommand);
}
