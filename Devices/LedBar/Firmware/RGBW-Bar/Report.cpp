#include <Arduino.h>

#include "Cron.h"
#include "Log.h"
#include "LoopMonitor.h"
#include "PowerMonitor.h"

#include "Report.h"

static bool report_periodically = false;

void ReportLoop() {
  if(report_periodically && CronEvery1Second()) {
    ReportLog();
  }
}

void ReportLog() {
  float voltage = 0;
  float current = 0;
  float power   = 0;
  PowerMonitorRead(voltage, current, power);

  LogPrintln("Voltage: %d mV", (int)(voltage * 1000));
  LogPrintln("Current: %d mA", (int)(current * 1000));
  LogPrintln("Power  : %d mW", (int)(power   * 1000));

  long last, min, max;
  LoopMonitorGet(last, min, max);
   
  LogPrintln("FPS (last, min, max): %ld, %ld, %ld",last, min, max);
}

void ReportPeriodically(bool enabled) {
  report_periodically = enabled;
}

