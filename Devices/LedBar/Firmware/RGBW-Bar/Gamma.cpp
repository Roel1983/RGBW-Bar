#include "Settings.h"

#include "Color.h"

void GammaColorCorrection(strip_color_t& color) {
  const float gamma = SettingsGetGamma();
  
  if (gamma != 0.0f) {
    for (int i; i < 4; i++) {
      color[i] = pow(((float)color[i] / 4094), gamma) * 4094;
    }
  }
}

