#ifndef _LEDS_HPP_
#define _LEDS_HPP_

#include <stdint.h>

namespace leds {

constexpr uint8_t GREEN  = 0;
constexpr uint8_t YELLOW = 1;
constexpr uint8_t ORANGE = 2;
constexpr uint8_t RED    = 3;

enum Action {
  LED_OFF,
  LED_ON,
  LED_BLINK_SLOW,
  LED_BLINK_FAST
};

void setup();
void loop();
void set  (uint8_t led_index, Action action);
bool blink(uint8_t led_index, uint8_t blink_count, bool is_repeat = false);

} // End of: namespace leds

#endif // _LEDS_HPP_
