//#ifndef TIMEPROFILER_H_
//#define TIMEPROFILER_H_

#include <Arduino.h>

#define TIME_PROFILER_ENABLED 0

typedef enum {
  TP_CRON,
  TP_BUTTON,
  TP_LOOP_MONITOR,
  TP_POWER_MONITOR,
  TP_REPORT,
  TP_COMMAND,
  TP_LED,
  TP_LIGHT_CONTROL,
  TP_STRIP,
  TP_LOOP
} time_profiler_category_t;
static constexpr size_t TP_CATEGORY_COUNT = TP_LOOP + 1;

#if TIME_PROFILER_ENABLED
  void TimeProfilerBegin();
  void TimeProfilerTrace(time_profiler_category_t bucket);
  void TimeProfilerReport();
#else
  inline void TimeProfilerBegin() {};
  inline void TimeProfilerTrace(time_profiler_category_t bucket) {};
  inline void TimeProfilerReport() {};
#endif
//#endif // TIMEPROFILER_H_

