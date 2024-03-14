#include <avr/interrupt.h>

#include "cron.hpp"
#include "communication/communication.hpp"
#include "button.hpp"
#include "deviceId.hpp"
#include "i2c.hpp"
#include "jumpers.hpp"
#include "leds.hpp"
#include "lightControl.hpp"
#include "strip.hpp"
#include "timestamp.hpp"

#include <avr/interrupt.h>
#include <avr/io.h>
#include <util/delay.h>

#include <string.h>

#include "timestamp.hpp"
#include "communication/send_strategy.hpp"
#include "communication/sender/sender.hpp"

void Setup();
void Loop();

#ifndef UNITTEST
int main (void)
{
	Setup();
	while(1) {
		Loop();
	}
}
#endif

void Setup() {
	timestamp::setup();
	cron::setup();
	communication::setup();
	jumpers::setup();
	deviceId::setup();
	communication::commandTypeSetBlockNr(communication::COMMAND_TYPE_UNIQUE_ID, deviceId::get());
	button::setup();
	leds::setup();
	i2c::setup();
	lightControl::setup();
	
	leds::blink(leds::GREEN, deviceId::get(), false);
	
	sei();
	
	strip::setup();

	lightControl::setFollow(false);
	lightControl::setOn(true);
	
	DDRC &= ~_BV(0);
	PORTC |= _BV(0);
	DDRB  |= _BV(5);
}

int button_cnt = 0;
bool button_state = false;
void Loop() {
	button::loop();
	cron::loop();
	communication::loop();
	lightControl::loop();
	strip::loop();
	
	if (strip::hasError()) {
		if (button::isPressedShort()) {
			strip::resetError();
		}
		if(button::isPressedLong()) {
			// TODO send group command to reset all strip errors
		}
	} else if (!lightControl::isOn()) {
		if (button::isPressedShort()) {
			communication::sendBroadcast( // Might reject
					02,
					1,
					[](bool is_timeout, uint8_t& payload_size, uint8_t *payload_buffer) -> bool {
						if (!is_timeout) {
							lightControl::setOn(true);
							*payload_buffer = lightControl::ACTION_ON;
						}
						return true;
					});
		}
	} else {
		if (button::isPressedShort()) {
			lightControl::toggleFlut();
		}
		if (button::isPressedLong()) {
			static bool is_follow;
			is_follow = !lightControl::isFollow();
			communication::sendBroadcast(
					02,
					1,
					[](bool is_timeout, uint8_t& payload_size, uint8_t *payload_buffer) -> bool {
						if (!is_timeout) {
							lightControl::setFollow(is_follow);
							lightControl::setFlut(false);
							*payload_buffer =
									(is_follow
										? lightControl::ACTION_FOLLOW_ON
										: lightControl::ACTION_FOLLOW_OFF
									) | lightControl::ACTION_FLUT_OFF;
						}
						return true;
					});
		}
		if (button::isPressedVeryLong()) {
			communication::sendBroadcast( // Might reject
					02,
					1,
					[](bool is_timeout, uint8_t& payload_size, uint8_t *payload_buffer) -> bool {
						if (!is_timeout) {
							lightControl::setOn(false);
							*payload_buffer = lightControl::ACTION_OFF;
						}
						return true;
					});
		}
	}
}
