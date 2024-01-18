#include "Types.h"

#include "Color.h"
#include "Settings.h"
#include "Strip.h"
#include "Strobe.h"

#include "LightControl.h"

typedef struct {
  bool     b;
  factor_t factor;
} soft_bool_t;

typedef struct {
  ms_t     duration;
  struct {
    factor_t factor;
    color_t  colors[4];
  } from;
  struct {
    ms_t     timestamp;
    factor_t factor;
    color_t  colors[4];
  } to;
  color_t stashed_colors[4];
  bool    has_new_stashed_colors;
} fade_t;

static fade_t      fade      = {MS_INDEFINETE, {0, {0}}, {0, 0, {0}}, {0}, false};
static soft_bool_t is_on     = {false, FACTOR_MIN};
static soft_bool_t is_follow = {false, FACTOR_MIN};
static soft_bool_t is_flut   = {false, FACTOR_MIN};
static bool        is_error  = false;

static ms_t        last_timestamp;
static factor_t    fade_current_factor;

static inline ms_t     LightControlCalculateDeltaTime (const ms_t timestamp);
static inline void     LightControlUpdateSoftBooleans (const ms_t delta_time);
static        void     LightControlUpdateSoftBoolean  (soft_bool_t& value, const factor_t delta);
static inline factor_t LightControlCalculateFadeFactor(const ms_t timestamp);


void LightControlBegin() {
  last_timestamp = millis();
}

void LightControlLoop() {
  const ms_t timestamp  = millis();
  const ms_t delta_time = LightControlCalculateDeltaTime(timestamp);
  LightControlUpdateSoftBooleans(delta_time);
  fade_current_factor = LightControlCalculateFadeFactor(timestamp);

  const unsigned int fade_from_weight_when_no_strobe = (FACTOR_MAX - fade_current_factor);
  for (int strip_index = 0; strip_index < 4; strip_index++) {
    const color_t& color_from(fade.from.colors[strip_index]);
    const color_t& color_to  (fade.to.colors[strip_index]);
    color_t  color_out;

    factor_t strobe_factor = StrobeGetStripFactor(strip_index);
    if (strobe_factor == FACTOR_MIN) {
      for (int i = 0; i < 4; i++) {
        uint32_t c;
        c  = (uint32_t)color_from[i] * fade_from_weight_when_no_strobe;
        c += (uint32_t)color_to[i]   * fade_current_factor;
        c /= (uint32_t)FACTOR_MAX;
        color_out[i] = c;
      }
    } else {
      const color_t& strobe_color(StrobeGetStripColor(strip_index));
      for (int i = 0; i < 4; i++) {
        uint32_t c;
        c  = (uint32_t)color_from[i]   * fade_from_weight_when_no_strobe;
        c += (uint32_t)color_to[i]     * fade_current_factor;
        c += (uint32_t)strobe_color[i] * strobe_factor;
        c /= (uint32_t)FACTOR_MAX;
        if (c > 4094) c = 4094;
        color_out[i] = c;
      }
    }
    if (is_follow.factor != FACTOR_MAX) {
      const factor_t non_follow_weight = FACTOR_MAX - is_follow.factor;
      const color_t& work_color(SettingsGetWorkLightColor());
      for (int i = 0; i < 4; i++) {
        uint32_t c;
        c  = (uint32_t)work_color[i] * non_follow_weight;
        c += (uint32_t)color_out[i]  * is_follow.factor;
        c /= (uint32_t)FACTOR_MAX;
        color_out[i] = c;
      }
    }
    if (is_flut.factor != FACTOR_MIN) {
      const factor_t non_flut_weight = FACTOR_MAX - is_flut.factor;
      const color_t& flut_color(SettingsGetFlutLightColor());
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
    StripSet(strip_index, color_out);
  }
}


static inline ms_t LightControlCalculateDeltaTime(const ms_t timestamp) {
  const ms_t delta_time = timestamp - last_timestamp;
  last_timestamp = timestamp;
  return delta_time;
}

static inline void LightControlUpdateSoftBooleans(const ms_t delta_time) {
  const factor_t delta_factor = delta_time * 10;
  LightControlUpdateSoftBoolean(is_on,     delta_factor);
  LightControlUpdateSoftBoolean(is_follow, delta_factor);
  LightControlUpdateSoftBoolean(is_flut  , delta_factor);
}

static void LightControlUpdateSoftBoolean(soft_bool_t& value, const factor_t delta) {
  if(value.b) {
    if(value.factor < (FACTOR_MAX - delta)) {
      value.factor += delta;
    } else {
      value.factor = FACTOR_MAX;
    }
  } else {
    if(value.factor > (FACTOR_MIN + delta)) {
      value.factor -= delta;
    } else {
      value.factor = FACTOR_MIN;
    }
  }
}

static inline factor_t LightControlCalculateFadeFactor(const ms_t timestamp) {
  if (fade.duration == MS_INDEFINETE) {
    return fade.from.factor;
  }
  const long fade_time_left = (long)fade.to.timestamp - timestamp;
  if (fade_time_left <= 0) {
    fade.to.timestamp = timestamp;
    return fade.to.factor;
  }
  
  const ms_t fade_time_elapsed = (fade.duration - fade_time_left);

  uint32_t result;
  result  = fade.to.factor   * fade_time_elapsed;
  result += fade.from.factor * fade_time_left;
  result /= fade.duration;
  return result;
}

void LightControlSetOn(bool value) {
  is_on.b = value;
  if(is_error) {
    is_on.factor = is_on.b ? FACTOR_MIN : FACTOR_MAX;
  }
}

bool LightControlIsOn() {
  return is_on.b;
}

void LightControlSetFollow(bool value) {
  is_follow.b = value;
  if(is_error || is_on.factor == FACTOR_MIN || is_flut.factor == FACTOR_MAX) {
    is_follow.factor = is_follow.b ? FACTOR_MIN : FACTOR_MAX;
  }
}

bool LightControlIsFollow() {
  return is_follow.b;
}

void LightControlSetFlut(bool value) {
  is_flut.b = value;
  if(is_error || is_on.factor == FACTOR_MIN) {
    is_flut.factor = is_flut.b ? FACTOR_MIN : FACTOR_MAX;
  }
}

bool LightControlIsFlut() {
  return is_flut.b;
}

void LightControlRaiseError() {
  is_error = true;
}

void LightControlClearError() {
  if(is_error) {
    is_error = false;
    is_on.factor = FACTOR_MIN;
  }
}

void LightControlFollowTargetColor(int strip_index, const color_t& color) {
  memcpy(fade.stashed_colors[strip_index], color, sizeof(color_t));
  fade.has_new_stashed_colors = true;
}

void LightConstrolApplyTargetColors() {
  if(fade.has_new_stashed_colors) {
    fade.has_new_stashed_colors = false;
    const factor_t from_weight = (FACTOR_MAX - fade_current_factor);
    const factor_t to_weight   = fade_current_factor;
    
    for (int strip_index2 = 0; strip_index2 < 4; strip_index2++) {
      const color_t& color_from(fade.from.colors[strip_index2]);
      const color_t& color_to  (fade.to.colors[strip_index2]);
      for (int i = 0; i < 4; i++) {
        uint32_t c;
        c  = (uint32_t)color_from[i] * from_weight;
        c += (uint32_t)color_to[i]   * to_weight;
        c /= (uint32_t)FACTOR_MAX;
        fade.from.colors[strip_index2][i] = c;
      }
    }
    memcpy(fade.to.colors, fade.stashed_colors, sizeof(color_t[4]));
    fade.from.factor = 0;
    fade.duration    = MS_INDEFINETE;
  }
}

void LightControlFollowTargetFactor(const factor_t factor, const ms_t duration) {
  fade.from.factor = fade_current_factor;
  fade.to.factor   = factor;

  const ms_t timestamp = millis();
  fade.duration        = duration;
  fade.to.timestamp    = timestamp + duration;
}

