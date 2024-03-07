#ifndef _PINS_HPP_
#define _PINS_HPP_

#include <avr/io.h>

#include <stdint.h>

struct Port {
	volatile uint8_t& ddr;
	volatile uint8_t& port;
	volatile uint8_t& pin;
};

struct Pin {
	Port    port;
	uint8_t bit_mask;
};

constexpr bool LOW    = false;
constexpr bool HIGH   = true;

constexpr Port PORT_B = {DDRB, PORTB, PINB};
constexpr Port PORT_C = {DDRC, PORTC, PINC};
constexpr Port PORT_D = {DDRD, PORTD, PIND};

constexpr Pin PIN00 = {PORT_D, _BV(0)};
constexpr Pin PIN01 = {PORT_D, _BV(1)};
constexpr Pin PIN02 = {PORT_D, _BV(2)};
constexpr Pin PIN03 = {PORT_D, _BV(3)};
constexpr Pin PIN04 = {PORT_D, _BV(4)};
constexpr Pin PIN05 = {PORT_D, _BV(5)};
constexpr Pin PIN06 = {PORT_D, _BV(6)};
constexpr Pin PIN07 = {PORT_D, _BV(7)};
constexpr Pin PIN08 = {PORT_B, _BV(0)};
constexpr Pin PIN09 = {PORT_B, _BV(1)};
constexpr Pin PIN10 = {PORT_B, _BV(2)};
constexpr Pin PIN11 = {PORT_B, _BV(3)};
constexpr Pin PIN12 = {PORT_B, _BV(4)};
constexpr Pin PIN13 = {PORT_B, _BV(5)};
constexpr Pin PIN14 = {PORT_C, _BV(0)};
constexpr Pin PIN15 = {PORT_C, _BV(1)};
constexpr Pin PIN16 = {PORT_C, _BV(2)};
constexpr Pin PIN17 = {PORT_C, _BV(3)};

#endif // _PINS_HPP_
