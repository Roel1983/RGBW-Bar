#ifndef _SETTINGS_HPP_
#define _SETTINGS_HPP_

#include "color.hpp"
#include "communication/communication.hpp"

namespace settings {

struct Settings {
	int32_t crc;
	
	uint8_t unique_id;
	
	uint8_t device_id;
	uint8_t group_id;
	uint8_t sun_id;
	uint8_t strip_id;

	Color   work_light_color;
	Color   flut_light_color;
};

void setup();
const Settings& get();

extern communication::receiver::CommandInfo read_command_info;
extern communication::receiver::CommandInfo write_command_info;

}

#endif // _SETTINGS_HPP_
