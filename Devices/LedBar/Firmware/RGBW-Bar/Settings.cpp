#include "Settings.h"

uint16_t SettingsGetOverVoltageMv() {
  return 12500;
}

const color_t& SettingsGetWorkLightColor() {
  static constexpr color_t WORK_LIGHT_COLOR = {1500, 1500, 1500, 3000};
  return WORK_LIGHT_COLOR;
}

const color_t& SettingsGetFlutLightColor() {
  static constexpr color_t FLUT_LIGHT_COLOR = {4094, 4094, 4094, 4094};
  return FLUT_LIGHT_COLOR;
}

