#include "stdint.h"

#include "timestamp.hpp"
#include "cron.hpp"

using timestamp::Timestamp;

namespace cron {
	
static Timestamp last_timestamp;
static uint8_t   counter;

void setup() {
	counter        = 0x01;
	last_timestamp = timestamp::getMsTimestamp();
}

void loop() {
	long timestamp = timestamp::getMsTimestamp();
  
	if (timestamp - last_timestamp > 250) {
		last_timestamp = timestamp;
		counter++;
		counter |= 0x80;
	} else {
		counter &= ~0x80;
	}
}

bool every4thSecond() {
	return (counter & (uint8_t)0x80) == (uint8_t)0x80;
}

bool every1Second() {
	return (counter & (uint8_t)0x83) == (uint8_t)0x80;
}

} // End of: namespace cron
