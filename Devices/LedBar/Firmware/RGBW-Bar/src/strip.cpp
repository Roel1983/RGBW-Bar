#include <string.h>

#include "color.hpp"
#include "i2c.hpp"
#include "pins.hpp"

#include "strip.hpp"

namespace strip {

constexpr uint8_t i2c_address_software_reset = 0x00;
constexpr uint8_t i2c_address_pca            = 0x40;

constexpr uint8_t pca_register_mode1         = 0x00;
constexpr uint8_t pca_register_all_led       = 0xfa;
constexpr uint8_t pca_register_prescaler     = 0xfe;

constexpr uint8_t pca_mode1_none             = 0x00;
constexpr uint8_t pca_mode1_sleep            = 0x10;
constexpr uint8_t pca_mode1_auto_increment   = 0x20;
constexpr uint8_t pca_mode1_restart          = 0x80;

static constexpr Pin pin_pca_oe    = PIN02;
static constexpr Pin pin_pca_ready = PIN16;

static Color colors[4] = {0};

static void pcaInit();
static void pcaAllOff();
static void pcaReady();

void setup() {
	pcaInit();
	pcaAllOff();
	pcaReady();
}

static void pcaInit() {
	i2c::send(i2c_address_software_reset, {
		0x06
	});
	
	//~ i2c::flush();
	for (volatile uint32_t w = 0; w < 0x120; w++);
	
	i2c::send(i2c_address_pca, {
		pca_register_mode1,
		pca_mode1_sleep
	});
	i2c::send(i2c_address_pca, {
		pca_register_prescaler,
		0x04
	});
	i2c::send(i2c_address_pca, {
		pca_register_mode1,
		pca_mode1_none
	});
	
	//~ i2c::flush();
	for (volatile uint32_t w = 0; w < 0x120; w++);
	
	i2c::send(i2c_address_pca, {
		pca_register_mode1,
		0xA0
	});
	
	//i2c::flush();
}

static void pcaAllOff() {
	
	// i2c::flush();
	for (volatile uint16_t w = 0; w < 0xFFF; w++);
}

static void pcaReady() {
	pin_pca_oe.port.ddr  |=  pin_pca_oe.bit_mask;
	pin_pca_oe.port.port &= ~pin_pca_oe.bit_mask;
	
	// TODO brown-out detection and error
}

void loop() {
	//i2c::send(i2c_address_pca, {0x06, 0x00, 0x02, 0x00, 0x00});
	
	static uint8_t buffer[5] = {0x06, 0x00, 0x00, 0x00, 0x00};
	static uint16_t i = 0;
	
	i = i + 1;
	buffer[2] = (i >> 8) & 0x0f;
	buffer[1] = (i >> 0) & 0xff;

	i2c::send(i2c_address_pca, buffer);
}

void teardown() {
	// TODO
}

bool hasError() {
	// TODO
	return false;
}

void resetError() {
	// TODO
}

void powerInvalid() {
	// TODO
}

void powerValid() {
	// TODO
}

void set(int strip_index, const Color& color) {
	memcpy(&colors[strip_index][0], &color[0], sizeof(color));
}

} // End of: namespace strip
