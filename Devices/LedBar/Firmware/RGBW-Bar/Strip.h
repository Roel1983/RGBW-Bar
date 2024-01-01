#ifndef _STRIP_H_
#define _STRIP_H_

typedef uint16_t color_t[4];

void StripBegin();
void StripLoop();
void StripEnd();

bool StripHasError();
void StripResetError();

void StripSet(int index, color_t color);

#endif
