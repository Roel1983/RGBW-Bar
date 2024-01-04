#ifndef STROBE_H_
#define STROBE_H_

#include "Types.h"
#include "Color.h"

void              Strobe(ms_t on, ms_t off, uint8_t count);
factor_t          StrobeGetStripFactor(int index);
internal_color_t& StrobeGetStripColor (int index);

#endif
