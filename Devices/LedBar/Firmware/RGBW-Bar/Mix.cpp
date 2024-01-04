#include "Mix.h"

void MixColor(factor_t factor, internal_color_t from, internal_color_t to, internal_color_t& out) {
  uint32_t c;
  const factor_t inv_factor = (10000 - factor);
  for(int i; i < 4; i++) {
    c  = (uint32_t)from[i] * inv_factor;
    c += (uint32_t)to[i] * factor;
    c /= 10000;
    out[i] = c;
  }
}
