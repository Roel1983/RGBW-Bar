#ifndef _POWER_MONITOR_H_
#define _POWER_MONITOR_H_

void PowerMonitorBegin();
void PowerMonitorLoop();
void PowerMonitorRead(float& voltage, float& current, float& power);

#endif