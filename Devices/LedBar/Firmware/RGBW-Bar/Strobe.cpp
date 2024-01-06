#include "Strobe.h"

static ms_t          strobe_on;
static ms_t          strobe_off;
static uint8_t       strobe_count=0;
static bool          strobe_toggle;
static ms_t          strobe_next_change;
static strip_color_t strobe_colors[4]  = {{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094},{4094, 4094, 4094, 4094}};
static factor_t      strobe_strip_weight[4] = {FACTOR_MAX, FACTOR_MAX, FACTOR_MAX, FACTOR_MAX};

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
      if (strobe_count != COUNT_INFINITE) {
        strobe_count--;
      }
    }
  }
  return strobe_toggle?strobe_strip_weight[index]:0;  
}

internal_color_t& StrobeGetStripColor(int index) {
  return strobe_colors[index];
}

void StrobeSetStripColor (int index, internal_color_t color) {
  strobe_colors[index][0] = color[0];
  strobe_colors[index][1] = color[1];
  strobe_colors[index][2] = color[2];
  strobe_colors[index][3] = color[3]; 
}

void StrobeSetStripWeights(factor_t weights[4]) {
  strobe_strip_weight[0] = weights[0];
  strobe_strip_weight[1] = weights[1];
  strobe_strip_weight[2] = weights[2];
  strobe_strip_weight[3] = weights[3];
}

