//#define F_CPU = 14745600

#include "Bootloader.h"
#include "Button.h"
#include "Cron.h"
#include "Led.h"
#include "LoopMonitor.h"

#include <Wire.h>
#include <Adafruit_INA219.h>
Adafruit_INA219 ina219;


constexpr int analog_out_pin = 5;

void AnalogOutBegin() {
  pinMode(analog_out_pin, OUTPUT);
  analogWrite(analog_out_pin, 0);
}

void AnalogOutSetVoltage(float voltage) {
  int value = voltage * 255 / 10;
  if(value > 255) value = 255; else if(value < 0) value = 0;
  analogWrite(analog_out_pin, value);
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(124929);
  pinMode(17, OUTPUT);
  digitalWrite(17, HIGH);
  Serial.println("Test");

  ina219.begin(0x44);
  
  ButtonBegin();
  CronBegin();
  LedBegin();
  LedSet(0, LED_ON);
  AnalogOutBegin();
  LoopMonitorBegin();
}

void loop() {
  CronLoop();
  ButtonLoop();
  LoopMonitorLoop();
  
  if(ButtonIsPressedShort()) {
    LedSet(0, LED_OFF);
    LedSet(1, LED_ON);
    LedSet(2, LED_BLINK_SLOW);
    LedBlinkCount(3, 4, false);
  }
  if(ButtonIsPressedLong()) {
    LedSet(0, LED_ON);
    LedSet(1, LED_BLINK_FAST);
    LedSet(2, LED_ON);
    LedBlinkCount(3, 5, false);
  }
  if(ButtonIsPressedVeryLong()) {
    Serial.println("Start bootloader");
    Serial.flush();
    BootloaderExecute();
  }

  if(CronEvery1Second()) {
    float shuntvoltage = 0;
    float busvoltage = 0;
    float current_mA = 0;
    float loadvoltage = 0;
  
    shuntvoltage = ina219.getShuntVoltage_mV();
    busvoltage = ina219.getBusVoltage_V();
    current_mA = ina219.getCurrent_mA();
    loadvoltage = busvoltage + (shuntvoltage / 1000);
    
    Serial.print("Bus Voltage:   "); Serial.print(busvoltage); Serial.println(" V");
    Serial.print("Shunt Voltage: "); Serial.print(shuntvoltage); Serial.println(" mV");
    Serial.print("Load Voltage:  "); Serial.print(loadvoltage); Serial.println(" V");
    Serial.print("Current:       "); Serial.print(current_mA); Serial.println(" mA");
    Serial.println("");
  }

  if(CronEvery1Second()) {
    static int voltage = 0;

    voltage++;
    if(voltage > 10) voltage = 0;
    Serial.print("AnalogOut: voltage = "); Serial.println(voltage);
    AnalogOutSetVoltage(voltage);
  }
  
  LedLoop();
}

