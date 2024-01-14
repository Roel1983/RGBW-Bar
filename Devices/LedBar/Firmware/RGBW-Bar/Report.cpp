#include <Arduino.h>

#include "Cron.h"
#include "Log.h"
#include "LoopMonitor.h"
#include "PowerMonitor.h"
#include "MemoryMonitor.h"
#include "TimeProfiler.h"

#include "Report.h"

static bool report_periodically = false;

void ReportLoop() {
  if(report_periodically && CronEvery1Second()) {
    ReportLog();
  }
}

void ReportLog() {
  uint16_t voltage_mv = 0;
  uint16_t current_mA = 0;
  PowerMonitorRead(voltage_mv, current_mA);
  LogPrintln("Voltage: %d mV", voltage_mv);
  LogPrintln("Current: %d mA", current_mA);
  
  long last, min, max;
  LoopMonitorGet(last, min, max);
  LogPrintln("FPS (last, min, max): %ld, %ld, %ld",last, min, max);

  unsigned int heap, stack, free;
  MemoryMonitorGet(heap, stack, free);
  LogPrintln("heap: %u, stack: %u, free: %u",  heap, stack, free);

  TimeProfilerReport();
}

void ReportPeriodically(bool enabled) {
  report_periodically = enabled;
}

