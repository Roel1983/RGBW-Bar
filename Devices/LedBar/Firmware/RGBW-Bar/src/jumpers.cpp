#include <assert.h>
#include <stdint.h>

#include "pins.hpp"
#include "utils.hpp"

#include "jumpers.hpp"

namespace jumpers {

static constexpr Pin pins[]        = {PIN04, PIN06, PIN07, PIN08, PIN09};
static constexpr bool active_state = LOW;

void setup() {
	for (const Pin& pin : pins) {
		pin.port.ddr  &= ~pin.bit_mask;
		pin.port.port |=  pin.bit_mask;
	}
}

bool get(uint8_t index) {
	assert(index < GetArrLength(pins));
	
	const Pin& pin = pins[index];
	return (pin.port.pin & pin.bit_mask) == active_state;
}

} // End of: namespace jumpers
