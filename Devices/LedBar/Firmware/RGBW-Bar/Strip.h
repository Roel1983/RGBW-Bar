#ifndef _STRIP_H_
#define _STRIP_H_

#include "Color.h"

void StripBegin();
void StripLoop();
void StripEnd();

bool StripHasError();
void StripResetError();

void StripSet(int index, strip_color_t color);

#endif
