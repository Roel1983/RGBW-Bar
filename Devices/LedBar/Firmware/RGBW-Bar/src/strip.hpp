#ifndef _STRIP_HPP_
#define _STRIP_HPP_

#include "color.hpp"

namespace strip {
	
void setup();
void loop();
void teardown();

bool hasError();
void resetError();

void powerInvalid();
void powerValid();

void set(int strip_index, const Color& color);

} // End of: namespace strip

#endif // _STRIP_HPP_
