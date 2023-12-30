#include <Arduino.h>

#include "LoopMonitor.h"
#include "Cron.h"

static long lps_count;
static long lps_count_last = 0;
static long lps_count_min = 0;
static long lps_count_max = 0;

void LoopMonitorBegin() {
  lps_count          = 0;
}

void LoopMonitorLoop() {
  lps_count++;
  if (CronEvery1Second()) {
    lps_count_last = lps_count;
    if (lps_count_min == 0 || lps_count_min > lps_count) lps_count_min = lps_count;
    if (lps_count_max < lps_count) lps_count_max = lps_count;
    lps_count          = 0;
  }
}

void LoopMonitorGet(long &last, long &min, long &max) {
  last = lps_count_last;
  min  = lps_count_min;
  max  = lps_count_max;
}

