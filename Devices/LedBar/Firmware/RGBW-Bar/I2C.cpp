#include <Arduino.h>
#include <Wire.h>
#include "I2C.h"

bool is_locked = false;

void I2cBegin() {
  Wire.begin();
}

bool I2cLock() {
  if(is_locked) {
    return false;
  }
  is_locked = true;
  return true;
}

void I2cUnlock() {
  is_locked = false;
}
