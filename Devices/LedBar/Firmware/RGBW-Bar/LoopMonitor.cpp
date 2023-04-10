#include <Arduino.h>

#include "LoopMonitor.h"

static constexpr long lps_report_frequency = 1000;
static long lps_last_timestamp;
static long lps_count;

void LoopMonitorBegin() {
  lps_last_timestamp = millis();
  lps_count          = 0;
}

void LoopMonitorLoop() {
  long current_timestamp = millis();
  
  lps_count++;
  if (current_timestamp - lps_last_timestamp > lps_report_frequency) {
    Serial.print("LPS:"); Serial.println(lps_count * 1000 / lps_report_frequency);
    lps_last_timestamp = current_timestamp;
    lps_count          = 0;
  }
}

