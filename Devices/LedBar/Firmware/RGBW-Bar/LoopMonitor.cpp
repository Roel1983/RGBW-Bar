#include <Arduino.h>

#include "LoopMonitor.h"
#include "Cron.h"

static long lps_count;
static long lps_count_last = 0;
static long lps_count_min = 0;
static long lps_count_max = 0;

static void LoopMonitorReset();

void LoopMonitorBegin() {
  LoopMonitorReset();
}

void LoopMonitorLoop() {
  lps_count++;
  if (CronEvery4thSecond()) {
    lps_count_last = lps_count * 4;
    lps_count          = 0;
    
    if (lps_count_min == 0 || lps_count_min > lps_count_last) {
      lps_count_min = lps_count_last;
    }
    if (lps_count_max < lps_count_last) {
      lps_count_max = lps_count_last;
    }
  }
}

void LoopMonitorGet(long &last, long &min, long &max) {
  last = lps_count_last;
  min  = lps_count_min;
  max  = lps_count_max;
  LoopMonitorReset();
}

static void LoopMonitorReset() {
  lps_count = 0;
  lps_count_last = 0;
  lps_count_min = 0;
  lps_count_max = 0;
}

