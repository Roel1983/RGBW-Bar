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

void setup() {
  CommStart();
  DeviceIdBegin();
  I2cBegin();
  ButtonBegin();
  CronBegin();
  LedBegin();
  LedSet(0, LED_ON);
  AnalogOutBegin();
  LoopMonitorBegin();
  PowerMonitorBegin();

  LedBlinkCount(0, DeviceIdGet(), false);
}

void loop() {
  CronLoop();
  ButtonLoop();
  LoopMonitorLoop();
  PowerMonitorLoop();
  ReportLoop();
  CommandLoop();
  LedLoop();

  if(ButtonIsPressedVeryLong()) {
    LogPrintln("Start bootloader");
    BootloaderExecute();
  }
}

