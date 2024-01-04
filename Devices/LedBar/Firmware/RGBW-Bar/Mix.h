#ifndef MIX_H_
#define MIX_H_

#include "Color.h"
#include "Types.h"

void MixColor(factor_t factor, internal_color_t from, internal_color_t to, internal_color_t& out);

#endif // MIX_H_