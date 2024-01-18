#include <Arduino.h>

#include "AnalogOut.h"

static constexpr int analog_out_pin = 5;

void AnalogOutBegin() {
  pinMode(analog_out_pin, OUTPUT);
  analogWrite(analog_out_pin, 0);
}

void AnalogOutSetVoltage(uint16_t voltage_mv) {
  uint32_t value = (uint32_t)voltage_mv * 255 / 10000;
  if(value > 255) value = 255;
  analogWrite(analog_out_pin, value);
}
