#include "Fade.h"
#include "Mix.h"

static ms_t     fade_duration = MS_INDEFINETE;
static ms_t     fade_till;
static factor_t fade_factor_from;
static factor_t fade_factor_to;

static internal_color_t from_color[4] = {0};
static internal_color_t to_color[4] = {0};

static void FadeSetFactor(factor_t factor, ms_t duration);
static factor_t FadeGetFactor();

void FadeSetTargetColor(int index, internal_color_t c) {
  for (int i = 0; i < 4; i++) {
    FadeGetColor(i, from_color[i]);
  }
  memcpy(to_color[index], c, sizeof(internal_color_t));
  fade_factor_from= 0;
  fade_duration= MS_INDEFINETE;
}

void FadeSetTargetFactor(factor_t factor, ms_t duration) {
  fade_factor_from = FadeGetFactor();
  fade_factor_to   = factor;

  const ms_t      timestamp = millis();
  fade_duration = duration;
  fade_till     = timestamp + duration;
}

void FadeGetColor(int index, internal_color_t& out) {
  MixColor(FadeGetFactor(), from_color[index], to_color[index], out);
}

static factor_t FadeGetFactor() {
  using duration_t = int32_t;
  
  const ms_t       timestamp    = millis();
  const long       time_left    = (long)fade_till - timestamp;
  const ms_t       time_elapsed = (fade_duration - time_left);

  if (fade_duration == MS_INDEFINETE) {
    return fade_factor_from;
  }
  if (time_left <= 0) {
    fade_till = timestamp; // TODO make sure FadeGetFactor is called every loop
    return fade_factor_to;
  }
  
  using tmp_result_t = uint64_t;
  static_assert(sizeof(tmp_result_t) >= sizeof(fade_factor_from) + sizeof(ms_t), "type 'tmp_result_t' too small");
  
  uint32_t result;
  result  = fade_factor_to   * time_elapsed;
  result += fade_factor_from * time_left;
  result /= fade_duration;
  return result;
}