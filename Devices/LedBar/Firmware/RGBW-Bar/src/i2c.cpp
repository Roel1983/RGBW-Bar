#include <avr/interrupt.h>

#include "i2c.hpp"

namespace i2c {


volatile bool           is_locked = false;
volatile uint8_t        address;
volatile uint8_t        length;
volatile const uint8_t *data;
volatile uint8_t        index;

static inline void lock();

static inline void sendStart();
static inline void sendAddressForWrite(uint8_t address);
static inline void sendByte(uint8_t b);
static inline void sendStop();

void setup() {
	TWSR = 0;         // TWI Bit Rate Prescaler
	TWBR = 11;        // TWI Bit Rate Register
	
	TWCR = _BV(TWEN)  // TWI Enable Bit
	     | _BV(TWIE); // TWI Interrupt Enable
}

void send(uint8_t addr, const Payload& payload) {
	lock();
	
	address = addr;
	length  = payload.length;
	data    = payload.data;
	index   = 0;
	sendStart();
}

ISR(TWI_vect) {
	uint8_t status = TWSR & 0xF8;
	switch (status) {
	case 0x08: // A START condition has been transmitted
	//case 0x10: // A repeated START condition has been transmitted	
		sendAddressForWrite(address);
		break;
	case 0x18: // SLA+W has been transmitted; ACK has been received
	case 0x28: // Data byte has been transmitted; ACK has been receive
		if (index < length) {
			sendByte(data[index++]);
		} else {
			sendStop();
			is_locked = false;
		}
		break;
	}
}

void flush() {
	while (is_locked);
}

static inline void lock() {
	while(true) {
		flush();		
		cli();
		if (!is_locked) {
			is_locked = true;
			sei();
			break;
		}
		sei();
	}
}


static inline void sendStart() {
	TWCR = _BV(TWEN)   // TWI Enable Bit
	     | _BV(TWIE)   // TWI Interrupt Enable
	     | _BV(TWINT)  // TWI Interrupt Flag (clear)
	     | _BV(TWSTA); // TWI START Condition Bit
}

static inline void sendStop() {
	TWCR = _BV(TWEN)   // TWI Enable Bit
	//     | _BV(TWIE)   // TWI Interrupt Enable
	     | _BV(TWINT)  // TWI Interrupt Flag (clear)
	     | _BV(TWSTO); // TWI STOP Condition Bit
}

static inline void sendAddressForWrite(uint8_t address) {
	sendByte((address << 1) + 0);
}

static inline void sendByte(uint8_t b) {
	TWDR = b;
	TWCR = _BV(TWEN) // TWI Enable Bit
	     | _BV(TWIE)     // TWI Interrupt Enable
	     | _BV(TWINT);   // TWI Interrupt Flag (clear)
}

} // namespace i2c
