#ifndef _LIGHT_CONTROL_HPP_
#define _LIGHT_CONTROL_HPP_

#include "color.hpp"
#include "timestamp.hpp"
#include "types.hpp"
#include "communication/communication.hpp"

namespace lightControl {

enum Action {
	ACTION_OFF           = 1 << 0,
	ACTION_ON            = 2 << 0,
	ACTION_TOGGLE        = 3 << 0,
	ACTION_FOLLOW_OFF    = 1 << 2,
	ACTION_FOLLOW_ON     = 2 << 2,
	ACTION_FOLLOW_TOGGLE = 3 << 2,
	ACTION_FLUT_OFF      = 1 << 4,
	ACTION_FLUT_ON       = 2 << 4,
	ACTION_FLUT_TOGGLE   = 3 << 4,
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
