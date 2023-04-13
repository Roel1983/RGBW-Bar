#include <Arduino.h>

#include "AnalogOut.h"

static constexpr int analog_out_pin = 5;

void AnalogOutBegin() {
  pinMode(analog_out_pin, OUTPUT);
  analogWrite(analog_out_pin, 0);
}

void AnalogOutSetVoltage(float voltage) {
  int value = voltage * 255 / 10;
  if(value > 255) value = 255; else if(value < 0) value = 0;
  analogWrite(analog_out_pin, value);
}
