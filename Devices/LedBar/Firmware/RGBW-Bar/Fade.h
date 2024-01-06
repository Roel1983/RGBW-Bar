#ifndef FADE_H_
#define FADE_H_

#include "Color.h"
#include "Types.h"

void FadeLoop();

void FadeSetTargetColor(int index, internal_color_t c);
void FadeSetTargetFactor(factor_t factor, ms_t duration);

void FadeGetColor(int index, internal_color_t& out);

#endif
