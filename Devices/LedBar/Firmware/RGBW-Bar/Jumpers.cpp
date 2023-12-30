#include <Arduino.h>

static constexpr int jumpers_pinnr[]      =  {4, 6, 7, 8, 9};
static constexpr int jumpers_active_state =  LOW;

void JumpersBegin() {
  for (int pin_nr : jumpers_pinnr) {
    pinMode(pin_nr, INPUT_PULLUP);
  }
}

bool JumpersGet(int index) {
  return (digitalRead(jumpers_pinnr[index]) == jumpers_active_state);
}

