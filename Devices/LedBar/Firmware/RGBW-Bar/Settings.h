#ifndef SETTINGS_H_
#define SETTINGS_H_

#include "Color.h"

uint16_t SettingsGetOverVoltageMv();

const color_t& SettingsGetWorkLightColor();
const color_t& SettingsGetFlutLightColor();

#endif
