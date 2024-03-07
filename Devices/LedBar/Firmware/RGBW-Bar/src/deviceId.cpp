#include "jumpers.hpp"

#include "deviceId.hpp"

namespace deviceId {

static uint8_t device_id;

void setup() {
	jumpers::setup();
	
	device_id = 0;
	for (int i = 0; i < 4; i++) {
		device_id <<= 1;
		device_id |= (jumpers::get(3 - i) ? 1 : 0);
	}
}

uint8_t get() {
	return device_id;
}
	
} // End of: namespace deviceId {
