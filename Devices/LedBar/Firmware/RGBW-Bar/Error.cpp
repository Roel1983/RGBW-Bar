#include <Arduino.h>

#include "Led.h"

#include "Error.h"

static uint8_t error_state_bits = 0;

static inline int ErrorToBlinkCount(error_t error) {
  return error + 1;
}

void ErrorActivate(error_t error) {
  if((error_state_bits & bit(error)) == 0) {
    error_state_bits |= bit(error);
    LedBlinkCount(LED_RED, ErrorToBlinkCount(error), true);
  }
}

void ErrorDeactivate(error_t error) {
  if((error_state_bits & bit(error)) != 0) {
    error_state_bits &= ~bit(error);
    if(error_state_bits) {
      for(int old_error = 0; old_error < 8; old_error++) {
        if((error_state_bits & bit(old_error)) != 0) {
          LedBlinkCount(LED_RED, ErrorToBlinkCount(old_error), true);
          return;
        }
      }
    }
    LedSet(LED_RED, LED_OFF);
  }
}

void ErrorRaise(error_t error) {
  if(!error_state_bits) {
    LedBlinkCount(LED_RED, ErrorToBlinkCount(error), false);
  }
}

