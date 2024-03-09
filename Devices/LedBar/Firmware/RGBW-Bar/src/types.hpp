#ifndef _TYPES_HPP_
#define _TYPES_HPP_

#include <stdint.h>

using Factor = uint16_t;

static constexpr Factor FACTOR_MIN =    0;
static constexpr Factor FACTOR_MAX = 8192;

static constexpr timestamp::Timestamp INDEFINETE = 0xFFFF;

#endif // _TYPES_HPP_
