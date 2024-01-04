#ifndef MIXER_H_
#define MIXER_H_

#include "Color.h"
#include "Factor.h"

color_rgbw_t& MixColor(factor_t factor, color_rgbw_t& color1, color_rgbw_t& color2);

#endif // MIXER_H_