#ifndef LIGHT_CONTROL_H_
#define LIGHT_CONTROL_H_

void LightControlBegin();
void LightControlLoop();

void LightControlSetOn(bool value);

void LightControlSetFollow(bool value);
bool LightControlGetFollow();

void LightControlSetFlut(bool value);
bool LightControlGetFlut();

void LightControlRaiseError();
void LightControlClearError();

#endif

