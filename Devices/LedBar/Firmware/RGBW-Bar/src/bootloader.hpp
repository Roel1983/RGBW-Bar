#ifndef _BOOTLOADER_HPP_
#define _BOOTLOADER_HPP_

#include "communication/communication.hpp"

namespace bootloader {

void execute();

extern communication::receiver::CommandInfo bootloader_command_info;

} // End of: namespace bootloader

#endif
