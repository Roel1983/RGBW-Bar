//#define F_CPU = 14745600

#include "AnalogOut.h"
#include "Bootloader.h"
#include "Button.h"
#include "Comm.h"
#include "Command.h"
#include "Cron.h"
#include "I2C.h"
#include "DeviceId.h"
#include "Led.h"
#include "Log.h"
#include "LoopMonitor.h"
#include "PowerMonitor.h"
#include "Report.h"
#include "Strip.h"

void setup() {
  CommStart();
  DeviceIdBegin();
  I2cBegin();
  ButtonBegin();
  CronBegin();
  LedBegin();
  AnalogOutBegin();
  LoopMonitorBegin();
  PowerMonitorBegin();
  StripBegin();
  
  LedSet(0, LED_ON);
  LedBlinkCount(0, DeviceIdGet(), false);
}

static bool led_overide = false;

void loop() {
  CronLoop();
  ButtonLoop();
  LoopMonitorLoop();
  PowerMonitorLoop();
  ReportLoop();
  CommandLoop();
  LedLoop();
  StripLoop();

  if(ButtonIsPressedVeryLong()) {
    LogPrintln("Start bootloader");
    BootloaderExecute();
  }

  
  if(StripHasError()) {
    LedBlinkCount(LED_RED, 2, true);
    if(ButtonIsPressedShort()) {
      StripResetError();
    }
  } else {
    LedSet(LED_RED, LED_OFF);
    if(ButtonIsPressedShort()) {
      if(!led_overide) {
        led_overide = true;//led_overide;
      } else {
        led_overide = false;
      }
    }
  }

  static uint16_t c = 0;
  c++;
  if(c > 1024) c = 0;
  
  color_t color1 = {c, 0, 0, 0};
  color_t color2 = {0, c, 0, 0};
  color_t color3 = {0, 0, c, 0};
  color_t color4 = {0, 0, 0, c};

  if(led_overide) {
    static constexpr color_t WHITE = {4093, 4093, 4093, 4093};
      StripSet(0, WHITE);
      StripSet(1, WHITE);
      StripSet(2, WHITE);
      StripSet(3, WHITE);
  } else {
    StripSet(0, color1);
    StripSet(1, color2);
    StripSet(2, color3);
    StripSet(3, color4);    
  }
}
