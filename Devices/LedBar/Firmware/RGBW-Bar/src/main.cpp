#include <avr/interrupt.h>

#include "cron.hpp"
#include "deviceId.hpp"
#include "leds.hpp"
#include "timestamp.hpp"

void setup();
void loop();

void setup() {
	cron::setup();
	deviceId::setup();
	leds::setup();
	timestamp::setup();
	
	leds::blink(leds::GREEN, deviceId::get(), false);
	
	sei();
}

void loop() {
	cron::loop();
	leds::loop();
}

int main() {
	setup();
	while(true) {
		loop();
	}
}
