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
#include "LightControl.h"
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
  LightControlBegin();
  CommandBegin();
  
  LedSet(0, LED_ON);
  LedBlinkCount(0, DeviceIdGet(), false);

  LightControlSetOn(true);
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
  FadeLoop();
  LightControlLoop();
  StripLoop();

  if(StripHasError()) {
    if(ButtonIsPressedShort()) {
      StripResetError();
    }    
  } else {
    if(ButtonIsPressedShort()) {
      LightControlSetFlut(!LightControlGetFlut());
    }
    if(ButtonIsPressedLong()) {
      CommandSend([](char* buffer, size_t size) -> size_t {
        bool is_follow = !LightControlGetFollow();
        size_t s = snprintf ( buffer, size, is_follow?"follow()":"work()");
        if(s <= size) {
          LightControlSetFollow(is_follow);
          LightControlSetFlut(false);
          return s;
        } else {
          return 0;
        }
      });
    }
  }
  
  if(ButtonIsPressedVeryLong()) {
    LogPrintln("Start bootloader");
    end();
    BootloaderExecute();
  }

}

