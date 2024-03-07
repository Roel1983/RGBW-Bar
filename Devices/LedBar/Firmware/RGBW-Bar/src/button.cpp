#include "pins.hpp"
#include "timestamp.hpp"

#include "button.hpp"

using timestamp::Timestamp;

namespace button {
	
// TODO Use enums instead of ints for state variables

static constexpr Pin  pin             = PIN14;
static constexpr int  debound_delay   =   10;
static constexpr long long_press      =  500;
static constexpr long very_long_press = 5000;

static int  event;
static bool new_event;

void setup() {
	pin.port.ddr  &= ~pin.bit_mask;
	pin.port.port |=  pin.bit_mask;
}

void loop() {
	static int  state = -1;
	static long pressed_timestamp;
	static long release_timestamp;
  
	bool is_pressed = !(pin.port.pin & pin.bit_mask);

	Timestamp current_timestamp = timestamp::getMsTimestamp();
	new_event = false;

	switch (state) {
	case -1:
		if (!is_pressed) {
			state = 0;
		}
		break;
	case 0:
		if (is_pressed) {
			pressed_timestamp = current_timestamp;
			state = 1;
			event = 0;
		}
		break;
	case 3:
		if (is_pressed) {
			state = 1;
		} else {
			if (timestamp::getMsTimestamp() - release_timestamp > debound_delay) {
				if (event == 0) {
					event = 1;
					new_event = true;
				}
				state = 0;
			}
			break;
		}
	case 1: // Fall-through
		if (!is_pressed) {
			release_timestamp = current_timestamp;
			state = 3;
		} else {
			if (event == 0) {
				if (current_timestamp - pressed_timestamp > long_press) {
					event = 2;
					new_event = true;
				}
			} else if(event == 2) {
				if (current_timestamp - pressed_timestamp > very_long_press) {
					event = 3;
					new_event = true;
				}
			}
		}
	}
}

bool isPressedShort() {
  return new_event && event == 1;
}

bool isPressedLong() {
  return new_event && event == 2;
}

bool isPressedVeryLong() {
  return new_event && event == 3;
}

} // End of: namespace button
