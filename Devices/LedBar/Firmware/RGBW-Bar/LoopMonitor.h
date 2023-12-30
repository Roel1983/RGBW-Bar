#ifndef _LOOP_MONITOR_H_
#define _LOOP_MONITOR_H_

void LoopMonitorBegin();
void LoopMonitorLoop();

void LoopMonitorGet(long &last, long &min, long &max);

#endif
