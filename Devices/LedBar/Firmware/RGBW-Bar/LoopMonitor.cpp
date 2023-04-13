#include <Arduino.h>

#include "LoopMonitor.h"
#include "Cron.h"

static long lps_count;

void LoopMonitorBegin() {
  lps_count          = 0;
}

void LoopMonitorLoop() {
  lps_count++;
  if (CronEvery1Second()) {
    Serial.print("LPS:"); Serial.println(lps_count);
    lps_count          = 0;
  }
}

