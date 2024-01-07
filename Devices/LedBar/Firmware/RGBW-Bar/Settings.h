#ifndef SETTINGS_H_
#define SETTINGS_H_

#include "Color.h"

float SettingsGetGamma();
float SettingsGetOverVoltage();

const strip_color_t& SettingsGetWorkLightColor();
const strip_color_t& SettingsGetFlutLightColor();

#endif
