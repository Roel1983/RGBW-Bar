#ifndef MIX_H_
#define MIX_H_

#include "Color.h"
#include "Types.h"

void MixColor(factor_t factor, const internal_color_t from, const internal_color_t to, internal_color_t& out);

#endif // MIX_H_
