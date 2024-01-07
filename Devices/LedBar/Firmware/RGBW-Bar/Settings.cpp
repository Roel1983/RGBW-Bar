#include "Settings.h"

float SettingsGetGamma() {
  return 1.5f;
}

float SettingsGetOverVoltage() {
  return 12.5f;
}


const strip_color_t& SettingsGetWorkLightColor() {
  static constexpr strip_color_t WORK_LIGHT_COLOR = {1500, 1500, 1500, 3000};
  return WORK_LIGHT_COLOR;
}

const strip_color_t& SettingsGetFlutLightColor() {
  static constexpr strip_color_t FLUT_LIGHT_COLOR = {4094, 4094, 4094, 4094};
  return FLUT_LIGHT_COLOR;
}

