#include "Types.h"
#include "Log.h"

#include "TimeProfiler.h"

#if TIME_PROFILER_ENABLED
  static unsigned long buckets[TP_CATEGORY_COUNT];
  static ms_t last_timestamp;
  static time_profiler_category_t current_bucket = TP_LOOP;
  
  static const char* TimeProfilerCategoryToStr(time_profiler_category_t bucket);
  
  void TimeProfilerBegin() {
    last_timestamp = millis();
  }
  
  void TimeProfilerTrace(time_profiler_category_t bucket) {
    const ms_t timestamp = millis();
    buckets[current_bucket] += timestamp - last_timestamp;
  
    last_timestamp = timestamp;
    current_bucket = bucket;
  }
  
  void TimeProfilerReport() {
    for (unsigned int i = 0; i < TP_CATEGORY_COUNT; i++) {
      LogPrintln("tp[%s] %ld", TimeProfilerCategoryToStr(static_cast<time_profiler_category_t>(i)), buckets[i]);
      buckets[i] = 0;
    }
  }
  
  static const char* TimeProfilerCategoryToStr(time_profiler_category_t bucket) {
    static const char* str[] = {
      "Cron",
      "Button",
      "LoopMonitor",
      "PowerMonitor",
      "Report",
      "Command",
      "Led",
      "Fade",
      "LightControler",
      "Strip",
      "Loop"
    };
    return str[bucket];
  }
#endif
