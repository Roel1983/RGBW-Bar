#include "Mix.h"

color_rgbw_t& MixColor(factor_t factor, color_rgbw_t& color1, color_rgbw_t& color2) {
  uint32_t channel;
  const factor_t inv_factor = (FACTOR_MAX - factor);
  for(int i; i < 4; i++) {
    channel  = (uint32_t)from[i] * inv_factor;
    channel += (uint32_t)to[i] * factor;
    channel /= FACTOR_MAX;
    out[i] = channel;
  }
}