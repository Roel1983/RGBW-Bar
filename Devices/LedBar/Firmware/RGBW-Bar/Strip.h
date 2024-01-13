#ifndef _STRIP_H_
#define _STRIP_H_

#include "Color.h"

void StripBegin();
void StripLoop();
void StripEnd();

bool StripHasError();
void StripResetError();

void StripPowerInvalid();
void StripPowerValid();

void StripSet(int strip_index, const strip_color_t& color);
void StripSet(const strip_color_t& color);

#endif
