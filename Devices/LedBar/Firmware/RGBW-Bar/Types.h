#ifndef TYPES_H_H
#define TYPES_H_H

#include <Arduino.h>

using factor_t = uint16_t;

static constexpr factor_t FACTOR_MIN =     0;
static constexpr factor_t FACTOR_MAX = 10000;

using ms_t = unsigned long;

static constexpr ms_t     MS_INDEFINETE = 0xFFFF;

#endif // TYPES_H_H
