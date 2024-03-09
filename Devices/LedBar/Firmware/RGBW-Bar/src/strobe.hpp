#ifndef _STROBE_HPP_
#define _STROBE_HPP_

#include "color.hpp"
#include "timestamp.hpp"
#include "types.hpp"

namespace strobe {

static constexpr uint8_t COUNT_INFINITE = 0xFF;

void         trigger        (timestamp::Timestamp on, timestamp::Timestamp off, uint8_t count);
Factor       getStripFactor (int index);
const Color& getStripColor  (int index);
void         setStripColor  (int index, const Color& color);
void         setStripWeights(Factor weights[4]);

} // End of: namespace strobe

#endif // _STROBE_HPP_
