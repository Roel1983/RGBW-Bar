#ifndef COLOR_H_
#define COLOR_H_

#include <Arduino.h>

typedef uint16_t color_rgbw_t[4];

using strip_color_t    = color_rgbw_t;
using internal_color_t = color_rgbw_t;

#endif // COLOR_H_