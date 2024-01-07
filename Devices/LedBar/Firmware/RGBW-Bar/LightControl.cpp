#include "Types.h"

#include "Color.h"
#include "Fade.h"
#include "Gamma.h"
#include "Mix.h"
#include "Settings.h"
#include "Strip.h"
#include "Strobe.h"

#include "LightControl.h"

typedef struct {
  bool     b;
  factor_t factor;
} soft_bool_t;

static soft_bool_t is_on     = {false, FACTOR_MIN};
static soft_bool_t is_follow = {false, FACTOR_MIN};
static soft_bool_t is_flut   = {false, FACTOR_MIN};
static bool        is_error  = false;

static ms_t        last_timestamp;

void UpdateSoftBool(soft_bool_t& value, factor_t delta);

void LightControlBegin() {
  last_timestamp = millis();
}

void LightControlLoop() {
  ms_t timestamp    = millis();
  ms_t time_elapsed = timestamp - last_timestamp;
  last_timestamp    = timestamp;

  factor_t delta = time_elapsed * 10; // 100% in 1 second
  UpdateSoftBool(is_on,     delta);
  UpdateSoftBool(is_follow, delta);
  UpdateSoftBool(is_flut,   delta);

  factor_t effective_on_factor = is_error ? FACTOR_MIN : is_on.factor;

  for(int i = 0; i < 4; i++) {
    strip_color_t color;

    static constexpr strip_color_t BLACK = {0, 0, 0, 0};

    //if(effective_on_factor != FACTOR_MIN) {
      // Calculate follow color
      FadeGetColor(i, color);
      MixColor(StrobeGetStripFactor(i), color, StrobeGetStripColor(i), color);
  
      // Mix with work light
      MixColor(is_follow.factor, SettingsGetWorkLightColor(), color, color);
  
      // Mix with flut light
      MixColor(is_flut.factor, color, SettingsGetFlutLightColor(), color);
   // }

    // Mix with off / error
    MixColor(effective_on_factor, BLACK, color, color);

    // End processing
    GammaColorCorrection(color);

    // Set color
    StripSet(i, color);
  }
}

void LightControlSetOn(bool value) {
  is_on.b = value;
  if(is_error) {
    is_on.factor = is_on.b ? FACTOR_MIN : FACTOR_MAX;
  }
}

void LightControlSetFollow(bool value) {
  is_follow.b = value;
  if(is_error || is_on.factor == FACTOR_MIN || is_flut.factor == FACTOR_MAX) {
    is_follow.factor = is_follow.b ? FACTOR_MIN : FACTOR_MAX;
  }
}

bool LightControlGetFollow() {
  return is_follow.b;
}

void LightControlSetFlut(bool value) {
  is_flut.b = value;
  if(is_error || is_on.factor == FACTOR_MIN) {
    is_flut.factor = is_flut.b ? FACTOR_MIN : FACTOR_MAX;
  }
}

bool LightControlGetFlut() {
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

void UpdateSoftBool(soft_bool_t& value, factor_t delta) {
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

