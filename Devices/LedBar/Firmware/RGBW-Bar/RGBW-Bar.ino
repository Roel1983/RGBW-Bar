//#define F_CPU = 14745600

#include "AnalogOut.h"
#include "Bootloader.h"
#include "Button.h"
#include "Comm.h"
#include "Command.h"
#include "Cron.h"
#include "I2C.h"
#include "DeviceId.h"
#include "Error.h"
#include "Led.h"
#include "Log.h"
#include "LoopMonitor.h"
#include "LightControl.h"
#include "PowerMonitor.h"
#include "Report.h"
#include "Strip.h"
#include "Strobe.h"
#include "TimeProfiler.h"

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
  TimeProfilerBegin();
  
  LedSet(0, LED_ON);
  LedBlinkCount(0, DeviceIdGet(), false);

  LightControlSetFollow(false);
  LightControlSetOn(true);
}

void end() {
  StripEnd();
}

static bool say_helo = true;

void loop() {
  TimeProfilerTrace(TP_CRON);
  CronLoop();
  
  TimeProfilerTrace(TP_BUTTON);
  ButtonLoop();
  
  TimeProfilerTrace(TP_LOOP_MONITOR);
  LoopMonitorLoop();
  
  TimeProfilerTrace(TP_POWER_MONITOR);
  PowerMonitorLoop();

  TimeProfilerTrace(TP_REPORT);
  ReportLoop();

  TimeProfilerTrace(TP_COMMAND);
  CommandLoop();

  TimeProfilerTrace(TP_LED);
  LedLoop();

  TimeProfilerTrace(TP_LIGHT_CONTROL);
  LightControlLoop();

  TimeProfilerTrace(TP_STRIP);
  StripLoop();

  ErrorLoop();

  TimeProfilerTrace(TP_LOOP);
  if(StripHasError()) {
    if(ButtonIsPressedShort()) {
      StripResetError();
    }
    if(ButtonIsPressedLong()) {
      CommandSend([](char* buffer, size_t size, bool talk_at_will) -> size_t {
        size_t s = snprintf ( buffer, size, "resetError()");
        if(s <= size) {
          StripResetError();
          return s;
        } else {
          return 0;
        }
      });
    }
  } else {
    if(ButtonIsPressedShort()) {
      LightControlSetFlut(!LightControlIsFlut());
    }
    if(ButtonIsPressedLong()) {
      CommandSend([](char* buffer, size_t size, bool talk_at_will) -> size_t {
        bool is_follow = !LightControlIsFollow();
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
    CommandSend([](char* buffer, size_t size, bool talk_at_will) -> size_t {
      bool is_on = !LightControlIsOn();
      size_t s = snprintf ( buffer, size, is_on?"on()":"off()");
      if(s <= size) {
        LightControlSetOn(is_on);
        return s;
      } else {
        return 0;
      }
    });
  }

}

