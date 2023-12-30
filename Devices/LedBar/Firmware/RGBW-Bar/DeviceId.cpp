#include <Arduino.h>

#include "Jumpers.h"

static uint8_t device_id;

void DeviceIdBegin() {
  JumpersBegin();
  for (int i = 0; i < 4; i++) {
    device_id <<= 1;
    device_id |= (JumpersGet(3 - i) ? 1 : 0);
  }
}

uint8_t DeviceIdGet() {
  return device_id;
}

