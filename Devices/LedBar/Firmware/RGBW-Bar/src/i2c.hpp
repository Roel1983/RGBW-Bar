#ifndef _I2C_HPP_
#define _I2C_HPP_

#include "third_party/initializer_list"

namespace i2c {

struct Payload;
	
void        setup();
inline void send(uint8_t address, uint8_t length, const uint8_t *data);
void        send(uint8_t address, const Payload& payload);
void        flush();

struct Payload {
	uint8_t length;
	const uint8_t *data;
	
	constexpr Payload(uint8_t length, const uint8_t *data) : length(length), data(data) {}
	
	template<size_t N>
	constexpr Payload(const uint8_t (&d)[N]) : length(N), data(d) {}
	constexpr Payload(std::initializer_list<uint8_t>&& data) : length(data.size()), data(data.begin()) {};
};


inline void send(uint8_t address, uint8_t length, const uint8_t *data) {
	Payload payload(length, data);
	send(address, payload);
}

} // namespace i2c

#endif // _I2C_HPP_
