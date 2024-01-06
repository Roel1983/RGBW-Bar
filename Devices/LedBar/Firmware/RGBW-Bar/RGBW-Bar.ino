//#define F_CPU = 14745600

#include "AnalogOut.h"
#include "Bootloader.h"
#include "Button.h"
#include "Comm.h"
#include "Command.h"
#include "Cron.h"
#include "I2C.h"
#include "DeviceId.h"
#include "Fade.h"
#include "Gamma.h"
#include "Led.h"
#include "Log.h"
#include "LoopMonitor.h"
#include "Mix.h"
#include "PowerMonitor.h"
#include "Report.h"
#include "Strip.h"
#include "Strobe.h"

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

void end() {
  StripEnd();
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
  FadeLoop();

  if(ButtonIsPressedVeryLong()) {
    LogPrintln("Start bootloader");
    end();
    BootloaderExecute();
  }
  
  if(StripHasError()) {
    if(ButtonIsPressedShort()) {
      StripResetError();
    }
  } else {
    if(ButtonIsPressedShort()) {
      if(!led_overide) {
        led_overide = true;//led_overide;
      } else {
        led_overide = false;
      }
    }
  }

  if(led_overide) {
    static constexpr strip_color_t WHITE = {4093, 4093, 4093, 4093};
    StripSet(0, WHITE);
    StripSet(1, WHITE);
    StripSet(2, WHITE);
    StripSet(3, WHITE);
 } else {
   for(int i = 0; i < 4; i++) {
    internal_color_t color;
    FadeGetColor(i, color);
    MixColor(StrobeGetStripFactor(i), color, StrobeGetStripColor(i), color);
    GammaColorCorrection(color);
    StripSet(i, color);
  }  
 }
}

