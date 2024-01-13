#ifndef LIGHT_CONTROL_H_
#define LIGHT_CONTROL_H_

#include "Color.h"
#include "Types.h"

void LightControlBegin();
void LightControlLoop();

void LightControlSetOn(bool value);

void LightControlSetFollow(bool value);
bool LightControlGetFollow();

void LightControlSetFlut(bool value);
bool LightControlGetFlut();

void LightControlRaiseError();
void LightControlClearError();

void LightControlFollowTargetColor(int strip_index, const color_t& color);
void LightControlFollowTargetFactor(const factor_t factor, const ms_t duration);

#endif

