#ifndef TIMESTAMP_H_
#define TIMESTAMP_H_

#include <stdint.h>

namespace timestamp {

using Timestamp = uint32_t;

void setup();

Timestamp getMsTimestamp();

} // End of: namespace timestamp
#endif
