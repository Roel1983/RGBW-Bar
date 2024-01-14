#ifndef _POWER_MONITOR_H_
#define _POWER_MONITOR_H_

void PowerMonitorBegin();
void PowerMonitorLoop();
void PowerMonitorRead(uint16_t& voltage_mv, uint16_t& current_mA);

#endif
