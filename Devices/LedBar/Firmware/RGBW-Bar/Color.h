#ifndef COLOR_H_
#define COLOR_H_

#include <Arduino.h>

typedef uint16_t color_rgbw_t[4];

using color_t          = color_rgbw_t;
using strip_color_t    = color_rgbw_t; // TODO remove
using internal_color_t = color_rgbw_t; // TODO remove

#endif // COLOR_H_
