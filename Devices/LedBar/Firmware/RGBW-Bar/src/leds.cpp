#include <assert.h>

#include "cron.hpp"
#include "leds.hpp"
#include "pins.hpp"
#include "utils.hpp"

namespace leds {
	
struct State {
	uint8_t   count     : 4;
	uint8_t   step      : 4;
	Action    action    : 2;
    bool      is_repeat : 1;
    bool      is_first  : 1;
};

static constexpr Pin pins[]        = {PIN13, PIN12, PIN11, PIN10};
static constexpr int led_count     = GetArrLength(pins);

static State states[led_count];

void setup() {
	for(uint8_t i = 0; i < led_count; i++) {
		const Pin& pin = pins[i];
		
		pin.port.ddr |= pin.bit_mask;
		states[i] = {0, 0, LED_OFF, false, false};
	}
}

void loop() {
	static int counter = 0;
  
	const bool tick = cron::every4thSecond();
	if (tick) {
		if (counter++ > 4) {
			counter = 0;
		}
	}
  
	for (size_t i = 0; i < led_count; i++) {
		State& state   = states[i];
		const Pin& pin = pins[i];

		if (state.count == 0) {
			bool is_on = false;
			switch (state.action) {
		    case LED_OFF:
				is_on = false;
				break;
			case LED_ON:
				is_on = true;
				break;
			case LED_BLINK_SLOW:
				is_on = (counter > 2);
				break;
			case LED_BLINK_FAST:
				is_on = (counter % 2);
				break;
			}
			if (is_on) {
				pin.port.port |=  pin.bit_mask;
			} else {
				pin.port.port &= ~pin.bit_mask;
			}
		} else {
			if (tick) {
				if (counter % 2) {
					if (state.step < state.count) {
						pin.port.port |=  pin.bit_mask;
					}
					if (state.step >= state.count) {
						state.step = 0;
						state.is_first = false;
						if (!state.is_repeat) {
							state.count = 0;
						}
					} else {
						state.step++;
					}
				} else {
					pin.port.port &= ~pin.bit_mask;
				}
			}
		}
	}
}

void set(uint8_t led_index, Action action) {
	assert(led_index < led_count);
	
	State& state = states[led_index];
	state.is_repeat = false;
	state.action    = action;
}

bool blink(uint8_t led_index, uint8_t blink_count, bool is_repeat) {
	assert(led_index < led_count);
	
	State& state = states[led_index];
	
	if(state.count && state.is_first) {
		return false;
	} else {
		state.is_repeat = true;
		state.step      = 0;
		state.count     = blink_count;
		state.is_first  = true;
		state.is_repeat = is_repeat;
		return true;
	}
}

} // End if: namespace leds
