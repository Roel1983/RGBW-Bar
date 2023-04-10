#ifndef _LED_H_
#define _LED_H_

enum LedAction {
  LED_OFF,
  LED_ON,
  LED_BLINK_SLOW,
  LED_BLINK_FAST
};

void LedBegin();
void LedLoop();
void LedSet(int led_nr, LedAction action);
bool LedBlinkCount(int led_nr, int count, bool is_repeat);

#endif

