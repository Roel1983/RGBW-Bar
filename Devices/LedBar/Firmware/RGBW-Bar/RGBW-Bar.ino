//#define F_CPU = 14745600

#include "Bootloader.h"
#include "Button.h"
#include "Led.h"
#include "LoopMonitor.h"

void setup() {
  // put your setup code here, to run once:
  Serial.begin(10448);
  pinMode(17, OUTPUT);
  digitalWrite(17, HIGH);
  Serial.println("Test");
  
  ButtonBegin();
  LedBegin();
  LedSet(0, LED_ON);
  LoopMonitorBegin();
}

void loop() {
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
  LedLoop();
}

