//#define F_CPU = 14745600

#include "AnalogOut.h"
#include "Bootloader.h"
#include "Button.h"
#include "Cron.h"
#include "Led.h"
#include "LoopMonitor.h"
#include "PowerMonitor.h"

void setup() {
  // put your setup code here, to run once:
  Serial.begin(124929);
  pinMode(17, OUTPUT);
  digitalWrite(17, HIGH);
  Serial.println("Test");

  ButtonBegin();
  CronBegin();
  LedBegin();
  LedSet(0, LED_ON);
  AnalogOutBegin();
  LoopMonitorBegin();
  PowerMonitorBegin();
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
    float voltage = 0;
    float current = 0;
    float power   = 0;

    PowerMonitorRead(voltage, current, power);
    
    Serial.print("Voltage:   "); Serial.print(voltage); Serial.println(" V");
    Serial.print("Current:   "); Serial.print(current); Serial.println(" A");
    Serial.print("Power:     "); Serial.print(power);   Serial.println(" W");
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

