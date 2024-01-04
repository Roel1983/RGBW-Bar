#include "Strobe.h"

// TODO: Set strobe color per strip
// TODO: Set factor per strip

static factor_t     strobe_strip_weight[4];
static ms_t         strobe_on;
static ms_t         strobe_off;
static uint8_t      strobe_count=0; // 0xFF is endless
static bool         strobe_toggle;
static ms_t         strobe_next_change;

void Strobe(ms_t on, ms_t off, uint8_t count) {
  strobe_on    = on;
  strobe_off   = off;
  strobe_count      = count;
  strobe_toggle = false;
  strobe_next_change = millis();
}

factor_t StrobeGetStripFactor(int index) {
  if(strobe_count == 0) {
    return 0;
  }
  ms_t timestamp = millis();
  if((long)(strobe_next_change - timestamp) <= 0) {
    strobe_toggle = !strobe_toggle;
    if(strobe_toggle) {
      strobe_next_change += strobe_on;
    } else {
      strobe_next_change += strobe_off;
      if (strobe_count != 0xFF) {
        strobe_count--;
      }
    }
  }
  return strobe_toggle?10000:0;  
}

internal_color_t& StrobeGetStripColor(int index) {
  static internal_color_t c = {4000,4000,4000,4000};
  return c;
}