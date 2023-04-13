#include <Arduino.h>

#include "Cron.h"

static long    last_timestamp;
static uint8_t cnt;

void CronBegin() {
  cnt = 0x01;
  last_timestamp = millis();
}

void CronLoop() {
  long timestamp = millis();
  if(timestamp - last_timestamp > 250) {
    last_timestamp = timestamp;
    cnt++;
    cnt |= 0x80;
  } else {
    cnt &= ~0x80;
  }
}

bool CronEvery4thSecond() {
  return (cnt & (uint8_t)0x80) == (uint8_t)0x80;
}
bool CronEvery1Second() {
  return (cnt & (uint8_t)0x83) == (uint8_t)0x80;
}

