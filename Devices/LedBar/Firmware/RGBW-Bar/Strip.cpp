#include <Arduino.h>

#include <Wire.h>

#include "Error.h"
#include "LightControl.h"

#include "Strip.h"

static constexpr int     pca9685_i2caddr  = 0x40;

static constexpr uint8_t pca9685_mode1    = 0x00;
static constexpr uint8_t pca9685_prescale = 0xFE;
static constexpr uint8_t pca9685_led0_l   = 0x06;

static void InitPca();
static void StripAllOff();
static void PcaReady();
static void Enable();
static void Disable();
static void OnError();

static bool error = false;
static color_t colors[4] = {0};
static bool power_valid = false;
static bool is_enabled = false;

void StripBegin() {
  InitPca();
  StripAllOff();
  PcaReady();
  memset(&colors, 0x00, sizeof(colors));
}

static void InitPca() {
  Wire.beginTransmission(pca9685_i2caddr);
  Wire.write(pca9685_mode1);
  Wire.write(0x00);
  Wire.endTransmission();

  Wire.beginTransmission(pca9685_i2caddr);
  Wire.write(pca9685_mode1);
  Wire.endTransmission();
  Wire.requestFrom((uint8_t)pca9685_i2caddr, (uint8_t)1);
  uint8_t oldmode= Wire.read();
  uint8_t newmode = (oldmode&0x7F) | 0x10; // sleep

  Wire.beginTransmission(pca9685_i2caddr);
  Wire.write(pca9685_mode1);
  Wire.write(newmode);
  Wire.endTransmission();

  Wire.beginTransmission(pca9685_i2caddr);
  Wire.write(pca9685_prescale);
  Wire.write(/*prescale*/ 2);
  Wire.endTransmission();

  Wire.beginTransmission(pca9685_i2caddr);
  Wire.write(pca9685_mode1);
  Wire.write(oldmode);
  Wire.endTransmission();

  delay(5);

  Wire.beginTransmission(pca9685_i2caddr);
  Wire.write(pca9685_mode1);
  Wire.write(oldmode | 0xa1);
  Wire.endTransmission();   
}

static void StripAllOff() {
  Wire.beginTransmission(pca9685_i2caddr);
  Wire.write(pca9685_led0_l);
  for (int i = 0; i < 32; i++) {
    Wire.write(0);
  }
  Wire.endTransmission(); 
}

static void PcaReady() {
  Enable();
  pinMode(16, OUTPUT); // pca_ready
  digitalWrite(16, LOW);

  if(digitalRead(2) == HIGH) {
    OnError();
  }
  attachInterrupt(digitalPinToInterrupt(2), [](){
    if (is_enabled) OnError();
  }, RISING);
  
}

void StripEnd() {
  Disable();
}

void StripLoop() {
  static int index = 0;
  Wire.beginTransmission(pca9685_i2caddr);
  Wire.write(pca9685_led0_l + 16 * index);
  Wire.write(0);
  Wire.write(0);
  Wire.write(colors[index][0] & 0xFF);
  Wire.write(colors[index][0] >> 8);
  Wire.write(0);
  Wire.write(0);
  Wire.write(colors[index][1] & 0xFF);
  Wire.write(colors[index][1] >> 8);
  Wire.write(0);
  Wire.write(0);
  Wire.write(colors[index][2] & 0xFF);
  Wire.write(colors[index][2] >> 8);
  Wire.write(0);
  Wire.write(0);
  Wire.write(colors[index][3] & 0xFF);
  Wire.write(colors[index][3] >> 8);
  Wire.endTransmission();
  index++;
  if (index > 4) index = 0;
}

static void Enable() {
  is_enabled = true;
  pinMode(2, INPUT); // pca_oe
}

static void Disable() {
  is_enabled = false;
  pinMode(2, OUTPUT); // pca_oe
  digitalWrite(2, HIGH); 
}

static void OnError() {
  Disable();
  error = true;
  ErrorActivate(ERROR_LED_STRIP_ERROR);
  LightControlRaiseError();
}

bool StripHasError() {
  return error;
}

void StripResetError() {
  // TODO reject if brownout active
  if(power_valid) Enable();
  error = false;
  ErrorDeactivate(ERROR_LED_STRIP_ERROR);
  LightControlClearError();
}

void StripSet(int strip_index, const color_t& color) {
  memcpy(&colors[strip_index][0], &color[0], sizeof(color));
}

void StripSet(const color_t& color) {
  for (int strip_index = 0; strip_index < 4; strip_index++) {
    StripSet(strip_index, color);
  }
}

void StripPowerInvalid() {
  if(power_valid) {
    Disable();
    power_valid = false;
    LightControlRaiseError();
  }
}

void StripPowerValid() {
  if(!error) Enable();
  if(!power_valid) {
    power_valid = true;
    LightControlClearError();
  }
}

