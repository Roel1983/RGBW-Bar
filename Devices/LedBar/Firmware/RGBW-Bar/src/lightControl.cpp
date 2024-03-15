#include <stdint.h>
#include <string.h>

#include "settings.hpp"
#include "strobe.hpp"
#include "strip.hpp"
#include "timestamp.hpp"
#include "types.hpp"

#include "leds.hpp" // TODO

#include "lightControl.hpp"

namespace lightControl {

using timestamp::Timestamp;
	
struct SoftBool {
  bool   b;
  Factor factor;
};

struct Fade {
  Timestamp   duration;
  struct {
    Factor    factor;
    Color     colors[4];
  } from;
  struct {
    Timestamp timestamp;
    Factor    factor;
    Color     colors[4];
  } to;
  Color       stashed_colors[4];
  bool        has_new_stashed_colors;
};

struct StripColorCommand;
struct TargetFactorCommand;
struct ApplyTargetColorsCommand;

static Fade      fade      = {INDEFINETE, {0, {0}}, {0, 0, {0}}, {0}, false};
static SoftBool  is_on     = {false, FACTOR_MIN};
static SoftBool  is_follow = {false, FACTOR_MIN};
static SoftBool  is_flut   = {false, FACTOR_MIN};
static bool      is_error  = false;

static Timestamp last_timestamp;
static Factor    fade_current_factor;

static inline Timestamp calculateDeltaTime (const Timestamp timestamp);
static inline void      updateSoftBooleans (const Timestamp delta_time);
static        void      updateSoftBoolean  (SoftBool& value, const Factor delta);
static inline Factor    calculateFadeFactor(const Timestamp timestamp);

static bool onLightControlCommand(const Action& command);
static bool onStripColorCommand(uint8_t index, const StripColorCommand& command);
static bool onTargetFactorCommand(const TargetFactorCommand& command);
static bool onApplyTargetColorsCommand(const ApplyTargetColorsCommand& command);

void setup() {
	last_timestamp = timestamp::getMsTimestamp();
}

void loop() {
	const Timestamp current_timestamp = timestamp::getMsTimestamp();
	const Timestamp delta_time        = calculateDeltaTime(current_timestamp);
	updateSoftBooleans(delta_time);
	fade_current_factor = calculateFadeFactor(current_timestamp);
	
	const Factor fade_from_weight_when_no_strobe = (FACTOR_MAX - fade_current_factor);
	for (int strip_index = 0; strip_index < 4; strip_index++) {
		const Color& color_from(fade.from.colors[strip_index]);
		const Color& color_to  (fade.to.colors[strip_index]);
		Color        color_out;

		Factor strobe_factor = strobe::getStripFactor(strip_index);
		if (strobe_factor == FACTOR_MIN) {
			for (int i = 0; i < 4; i++) {
				uint32_t c;
				c  = (uint32_t)color_from[i] * fade_from_weight_when_no_strobe;
				c += (uint32_t)color_to[i]   * fade_current_factor;
				c /= (uint32_t)FACTOR_MAX;
				color_out[i] = c;
			}
		} else {
			const Color& strobe_color(strobe::getStripColor(strip_index));
			for (int i = 0; i < 4; i++) {
				uint32_t c;
				c  = (uint32_t)color_from[i]   * fade_from_weight_when_no_strobe;
				c += (uint32_t)color_to[i]     * fade_current_factor;
				c += (uint32_t)strobe_color[i] * strobe_factor;
				c /= (uint32_t)FACTOR_MAX;
				if (c > 4094) {
					c = 4094;
				}
				color_out[i] = c;
			}
		}
		if (is_follow.factor != FACTOR_MAX) {
			const Factor non_follow_weight = FACTOR_MAX - is_follow.factor;
			const Color& work_color(settings::getWorkLightColor());
			for (int i = 0; i < 4; i++) {
				uint32_t c;
				c  = (uint32_t)work_color[i] * non_follow_weight;
				c += (uint32_t)color_out[i]  * is_follow.factor;
				c /= (uint32_t)FACTOR_MAX;
				color_out[i] = c;
			}
		}
		if (is_flut.factor != FACTOR_MIN) {
			const Factor non_flut_weight = FACTOR_MAX - is_flut.factor;
			const Color& flut_color(settings::getFlutLightColor());
			for (int i = 0; i < 4; i++) {
				uint32_t c;
				c  = (uint32_t)color_out[i]  * non_flut_weight;
				c += (uint32_t)flut_color[i] * is_flut.factor;
				c /= (uint32_t)FACTOR_MAX;
				color_out[i] = c;
			}
		}
		if (is_on.factor != FACTOR_MAX) {
			for (int i = 0; i < 4; i++) {
				uint32_t c = color_out[i];
				color_out[i] = c * is_on.factor / FACTOR_MAX;
			} 
		}
		for (int i = 0; i < 4; i++) {
			uint32_t c = color_out[i];
			color_out[i] = c * c / 4094; // Gamma correction
		}
		strip::set(strip_index, color_out);
	}
}

static inline Timestamp calculateDeltaTime(const Timestamp timestamp) {
	const Timestamp delta_time = timestamp - last_timestamp;
	last_timestamp = timestamp;
	return delta_time;
}

static inline void updateSoftBooleans(const Timestamp delta_time) {
	const Factor delta_factor = delta_time * 10;
	updateSoftBoolean(is_on,     delta_factor);
	updateSoftBoolean(is_follow, delta_factor);
	updateSoftBoolean(is_flut  , delta_factor);
}

static void updateSoftBoolean(SoftBool& value, const Factor delta) {
	if (value.b) {
		if (value.factor < (FACTOR_MAX - delta)) {
			value.factor += delta;
		} else {
			value.factor = FACTOR_MAX;
		}
	} else {
		if (value.factor > (FACTOR_MIN + delta)) {
			value.factor -= delta;
		} else {
			value.factor = FACTOR_MIN;
		}
	}
}

static inline Factor calculateFadeFactor(const Timestamp timestamp) {
	if (fade.duration == INDEFINETE) {
		return fade.from.factor;
	}
	const long fade_time_left = (long)fade.to.timestamp - timestamp;
	if (fade_time_left <= 0) {
		fade.to.timestamp = timestamp;
		return fade.to.factor;
	}
  
	const Timestamp fade_time_elapsed = (fade.duration - fade_time_left);

    uint32_t result;
	result  = fade.to.factor   * fade_time_elapsed;
	result += fade.from.factor * fade_time_left;
	result /= fade.duration;
	return result;
}

void setOn(bool value) {
	is_on.b = value;
	if (is_error) {
		is_on.factor = is_on.b ? FACTOR_MIN : FACTOR_MAX;
	}
}

bool isOn() {
	return is_on.b;
}

void setFollow(bool value) {
	is_follow.b = value;
	if (is_error || is_on.factor == FACTOR_MIN || is_flut.factor == FACTOR_MAX) {
		is_follow.factor = is_follow.b ? FACTOR_MIN : FACTOR_MAX;
	}
}

bool isFollow() {
	return is_follow.b;
}

void setFlut(bool value) {
	is_flut.b = value;
	if (is_error || is_on.factor == FACTOR_MIN) {
		is_flut.factor = is_flut.b ? FACTOR_MIN : FACTOR_MAX;
	}
}

bool toggleFlut() {
	setFlut(!is_flut.b);
	return is_flut.b;
}

bool isFlut() {
	return is_flut.b;
}

void raiseError() {
	is_error = true;
}

void clearError() {
	if (is_error) {
		is_on.factor = FACTOR_MIN;
		is_error = false;
	}
}

void followTargetColor(int strip_index, const Color& color)  {
	memcpy(fade.stashed_colors[strip_index], color, sizeof(color));
	fade.has_new_stashed_colors = true;
}

void followTargetFactor(const Factor factor, const Timestamp duration)  {
	fade.from.factor          = fade_current_factor;
	fade.to.factor            = factor;

	const Timestamp timestamp = timestamp::getMsTimestamp();
	fade.duration             = duration;
	fade.to.timestamp         = timestamp + duration;
}

void applyTargetColors() {
	if (fade.has_new_stashed_colors) {
		fade.has_new_stashed_colors = false;
		const Factor from_weight    = (FACTOR_MAX - fade_current_factor);
		const Factor to_weight      = fade_current_factor;
		
		for (int strip_index2 = 0; strip_index2 < 4; strip_index2++) {
			const Color& color_from(fade.from.colors[strip_index2]);
			const Color& color_to  (fade.to.colors[strip_index2]);
			for (int i = 0; i < 4; i++) {
				uint32_t c;
				c  = (uint32_t)color_from[i] * from_weight;
				c += (uint32_t)color_to[i]   * to_weight;
				c /= (uint32_t)FACTOR_MAX;
				fade.from.colors[strip_index2][i] = c;
			}
		}
		memcpy(fade.to.colors, fade.stashed_colors, sizeof(fade.stashed_colors));
		fade.from.factor = 0;
		fade.duration    = INDEFINETE;
	}
}
// TODO should be group
communication::receiver::Command<communication::COMMAND_TYPE_BROADCAST, Action> light_control_command;

communication::receiver::CommandInfo light_control_command_info(
	light_control_command,
	onLightControlCommand);
	
static bool onLightControlCommand(const Action& command) {
	switch(command & 0b000011) {
	case ACTION_OFF:
		setOn(false);
		break;
	case ACTION_ON:
		setOn(true);
		break;
	case ACTION_TOGGLE:
		setOn(!isOn());
		break;
	}
	switch(command & 0b001100) {
	case ACTION_FOLLOW_OFF:
		setFollow(false);
		break;
	case ACTION_FOLLOW_ON:
		setFollow(true);
		break;
	case ACTION_FOLLOW_TOGGLE:
		setFollow(!isFollow());
		break;
	}
	switch(command & 0b110000) {
	case ACTION_FLUT_OFF:
		setFlut(false);
		break;
	case ACTION_FLUT_ON:
		setFlut(true);
		break;
	case ACTION_FLUT_TOGGLE:
		setFlut(!isFollow());
		break;
	}
	
	return true;
};

struct StripColorCommand {
	Color color;
};

communication::receiver::Command<communication::COMMAND_TYPE_STRIP, StripColorCommand> strip_color_command;

communication::receiver::CommandInfo strip_color_command_info(
	strip_color_command,
	onStripColorCommand);

static bool onStripColorCommand(uint8_t relative_block_nr, const StripColorCommand& command) {
	followTargetColor(relative_block_nr, command.color);
	return true;
}

struct TargetFactorCommand {
	Factor factor;
	timestamp::Timestamp duration;
};

// TODO should be group
communication::receiver::Command<communication::COMMAND_TYPE_BROADCAST, TargetFactorCommand> target_factor_command;

communication::receiver::CommandInfo target_factor_command_info(
	target_factor_command,
	onTargetFactorCommand);

static bool onTargetFactorCommand(const TargetFactorCommand& command) {
	followTargetFactor(command.factor, command.duration);
	return true;
}

struct ApplyTargetColorsCommand {
};

// TODO should be group
communication::receiver::Command<communication::COMMAND_TYPE_BROADCAST, ApplyTargetColorsCommand> apply_target_colors_command;

communication::receiver::CommandInfo apply_target_colors_command_info(
	apply_target_colors_command,
	onApplyTargetColorsCommand);

static bool onApplyTargetColorsCommand(const ApplyTargetColorsCommand& command) {
	applyTargetColors();
	return true;
}

} // End of: namespace lightControl
