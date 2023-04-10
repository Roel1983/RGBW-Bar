#include <Arduino.h>

#include "Led.h"

typedef struct LedState {
  uint8_t   count     : 4;
  uint8_t   step      : 4;
  LedAction action    : 2;
  bool      is_repeat : 1;
  bool      is_first  : 1;
} LedState;

static constexpr size_t led_count        = 4;
static constexpr int    led_pinnr[]      = {13, 12, 11, 10};
static constexpr int    led_active_state = HIGH;
static constexpr long   led_blink_period = 250;

static long led_last_period_change;

static LedState led_state[led_count];

void LedBegin() {
  for(size_t i = 0; i < led_count; i++) {
    pinMode(led_pinnr[i], OUTPUT);    
    led_state[i] = {0, 0, LED_OFF, false, false};
  }
  led_last_period_change = millis();
}

void LedLoop() {
  static int cnt = 0;
  long timestamp = millis();
  
  bool tick = (timestamp - led_last_period_change > led_blink_period);
  if (tick) {
    led_last_period_change = timestamp;
    if(cnt++ > 4) cnt = 0;
  }
  
  for(size_t i = 0; i < led_count; i++) {
    LedState& state = led_state[i];

    if(state.count == 0) {
      switch(state.action) {
      case LED_OFF:
        digitalWrite(led_pinnr[i], (led_active_state==HIGH)?LOW:HIGH);
        break;
      case LED_ON:
        digitalWrite(led_pinnr[i], led_active_state);
        break;
      case LED_BLINK_SLOW:
        digitalWrite(led_pinnr[i], (cnt > 2)?HIGH:LOW);
        break;
      case LED_BLINK_FAST:
        digitalWrite(led_pinnr[i], (cnt % 2)?HIGH:LOW);
        break;
      }
    } else {
      if(tick) {
        if(cnt % 2) {
          if(state.step < state.count) {
            digitalWrite(led_pinnr[i], HIGH);
          }
          if(state.step >= state.count) {
            led_state[i].step = 0;
            led_state[i].is_first = false;
            if(!state.is_repeat) {
              led_state[i].count = 0;
            }
          } else {
            led_state[i].step++;
          }
        } else {
          digitalWrite(led_pinnr[i], LOW);
        }
      }
    }
  }
}

void LedSet(int led_nr, LedAction action) {
  led_state[led_nr].is_repeat = false;
  led_state[led_nr].action = action;
}

bool LedBlinkCount(int led_nr, int count, bool is_repeat) {
  if(led_state[led_nr].count && led_state[led_nr].is_first) {
    return false;
  } else {
    led_state[led_nr].is_repeat = true;
    led_state[led_nr].step      = 0;
    led_state[led_nr].count     = count;
    led_state[led_nr].is_first  = true;
    led_state[led_nr].is_repeat = is_repeat;
    return true;
  }
}
