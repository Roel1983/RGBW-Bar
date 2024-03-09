#include <avr/interrupt.h>

#include "cron.hpp"
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
}

void loop() {
	button::loop();
	cron::loop();
	leds::loop();
	lightControl::loop();
	strip::loop();
	
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
			// TODO send group command to toggle between work and follow
		}
	}
	if (button::isPressedVeryLong()) {
		// TODO send group command to toggle between on and off
	}
}

int main() {
	setup();
	while(true) {
		loop();
	}
}
