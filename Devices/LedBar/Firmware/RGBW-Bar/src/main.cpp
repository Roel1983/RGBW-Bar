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

void setup();
void loop();

void setup() {
	timestamp::setup();
	cron::setup();
	communication::setup();
	jumpers::setup();
	deviceId::setup();
	button::setup();
	leds::setup();
	i2c::setup();
	lightControl::setup();
	
	leds::blink(leds::GREEN, deviceId::get(), false);
	
	sei();
	
	strip::setup();
	
	lightControl::setFollow(false);
	lightControl::setOn(true);
	
	DDRC = _BV(1);
}

void loop() {
	button::loop();
	cron::loop();
	communication::loop();
	leds::loop();
	lightControl::loop();
	PORTC |= _BV(1);
	strip::loop();
	PORTC &= ~_BV(1);
	
	if (strip::hasError()) {
		if (button::isPressedShort()) {
			strip::resetError();
		}
		if(button::isPressedLong()) {
			// TODO send group command to reset all strip errors
		}
	} else {
		if (button::isPressedShort()) {
			lightControl::toggleFlut();
		}
		if (button::isPressedLong()) {
			const bool is_follow = !lightControl::isFollow();
			lightControl::setFollow(is_follow);
			lightControl::setFlut(false);
			// TODO send group command to toggle between work and follow
		}
	}
	if (button::isPressedVeryLong()) {
		const bool is_on = !lightControl::isOn();
		lightControl::setOn(is_on);
		// TODO send group command to toggle between on and off
	}
}

int main() {
	setup();
	while(true) {
		loop();
	}
}
