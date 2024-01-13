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

  TimeProfilerTrace(TP_LOOP);
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

