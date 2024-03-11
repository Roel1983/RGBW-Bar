#ifndef _LIGHT_CONTROL_HPP_
#define _LIGHT_CONTROL_HPP_

#include "color.hpp"
#include "timestamp.hpp"
#include "types.hpp"
#include "communication/communication.hpp"

namespace lightControl {

enum LightControlAction {
	LIGHT_CONTROL_ACTION_OFF,
	LIGHT_CONTROL_ACTION_ON,
	LIGHT_CONTROL_ACTION_FOLLOW_OFF,
	LIGHT_CONTROL_ACTION_FOLLOW_ON,
	LIGHT_CONTROL_ACTION_FLUT_OFF,
	LIGHT_CONTROL_ACTION_FLUT_ON
};

void setup();
void loop();

void setOn(bool value);
bool isOn();

void setFollow(bool value);
bool isFollow();

void setFlut(bool value);
bool toggleFlut();
bool isFlut();

void raiseError();
void clearError();

void followTargetColor(int strip_index, const Color& color);
void followTargetFactor(const Factor factor, const timestamp::Timestamp duration);

void applyTargetColors();

extern communication::receiver::CommandInfo light_control_command_info;

} // End of: namespace lightControl

#endif // _LIGHT_CONTROL_HPP_
