#ifndef STROBE_H_
#define STROBE_H_

#include "Types.h"
#include "Color.h"

static constexpr uint8_t COUNT_INFINITE = 0xFF;

void              Strobe(ms_t on, ms_t off, uint8_t count);
factor_t          StrobeGetStripFactor (int index);
const color_t&    StrobeGetStripColor  (int index);
void              StrobeSetStripColor  (int index, const color_t& color);
void              StrobeSetStripWeights(factor_t weights[4]);

#endif
