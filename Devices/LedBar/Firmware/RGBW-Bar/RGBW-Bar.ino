//#define F_CPU = 14745600

#include "AnalogOut.h"
#include "Bootloader.h"
#include "Button.h"
#include "Comm.h"
#include "Command.h"
#include "Cron.h"
#include "I2C.h"
#include "DeviceId.h"
#include "Fade.h"
#include "Led.h"
#include "Log.h"
#include "LoopMonitor.h"
#include "Mix.h"
#include "PowerMonitor.h"
#include "Report.h"
#include "Strip.h"
#include "Strobe.h"

void setup() {
  CommStart();
  DeviceIdBegin();
  I2cBegin();
  ButtonBegin();
  CronBegin();
  LedBegin();
  AnalogOutBegin();
  LoopMonitorBegin();
  PowerMonitorBegin();
  StripBegin();
  
  LedSet(0, LED_ON);
  LedBlinkCount(0, DeviceIdGet(), false);
}

void end() {
  StripEnd();
}

static bool led_overide = false;

void loop() {
  CronLoop();
  ButtonLoop();
  LoopMonitorLoop();
  PowerMonitorLoop();
  ReportLoop();
  CommandLoop();
  LedLoop();
  StripLoop();

  if(ButtonIsPressedVeryLong()) {
    LogPrintln("Start bootloader");
    end();
    BootloaderExecute();
  }

  
  if(StripHasError()) {
    LedBlinkCount(LED_RED, 2, true);
    if(ButtonIsPressedShort()) {
      StripResetError();
    }
  } else {
    LedSet(LED_RED, LED_OFF);
    if(ButtonIsPressedShort()) {
      if(!led_overide) {
        led_overide = true;//led_overide;
      } else {
        led_overide = false;
      }
    }
  }

  if(led_overide) {
    static constexpr strip_color_t WHITE = {4093, 4093, 4093, 4093};
    StripSet(0, WHITE);
    StripSet(1, WHITE);
    StripSet(2, WHITE);
    StripSet(3, WHITE);
 } else {
   for(int i = 0; i < 4; i++) {
    internal_color_t color;
    FadeGetColor(i, color);
    MixColor(StrobeGetStripFactor(i), color, StrobeGetStripColor(i), color);
    StripSet(i, color);
  }  
 }
}
//
//typedef uint16_t ms_t;
//typedef uint16_t factor_t;
//
//constexpr factor_t FACTOR_MIN =     0;
//constexpr factor_t FACTOR_MAX = 10000;
//
//constexpr ms_t     MS_INDEFINETE = 0xFFFF;
//
//static ms_t     fade_duration;
//static ms_t     fade_till;
//static factor_t fade_factor_from;
//static factor_t fade_factor_to;
//
//void FadeSetFactor(factor_t factor, ms_t duration);
//factor_t FadeGetFactor();
//
//void FadeSetFactor(factor_t factor, ms_t duration) {
//  fade_factor_from = FadeGetFactor();
//  fade_factor_to   = factor;
//
//  const uint16_t timestamp = millis();
//  fade_duration = duration;
//  fade_till     = timestamp + duration;
//}
//
//factor_t FadeGetFactor() {
//  using duration_t = int32_t;
//  static_assert(sizeof(ms_t) < sizeof(duration_t), "type 'duration_t' must be greater than 'ms_t'");
//  
//  const ms_t       timestamp = millis();
//  const duration_t time_left    = (int32_t)fade_till - timestamp;
//  const duration_t time_elapsed = (fade_duration - time_left);
//
//  if (fade_duration == MS_INDEFINETE) {
//    return FACTOR_MIN;
//  }
//  if (time_left <= 0) {
//    fade_till = timestamp;
//    return FACTOR_MAX;
//  }
//  
//  using tmp_result_t = uint32_t;
//  static_assert(sizeof(tmp_result_t) >= sizeof(fade_factor_from) + sizeof(ms_t), "type 'tmp_result_t' too small");
//  
//  uint32_t result;
//  result  = fade_factor_from * time_elapsed;
//  result += fade_factor_to   * time_left;
//  result /= fade_duration;
//  return result;
//}
//
//void ProgramSetNextColors() {
//  // From color is current color
//  // To color is new color
//  FadeSetFactor(0, MS_INDEFINETE);
//}

//typedef union {
//  uint16_t channel[3];
//  struct {
//    uint16_t hue;
//    uint16_t saturation;
//    uint16_t brightness;
//  };
//} hsv_t;
//typedef uint16_t intensity_t;
//typedef uint16_t factor_t;
//typedef uint16_t ms_t;
//
//
//
//
//
//
//void ProgramLoop();
//void ProgramSetNextColors(hsv_t strip_colors[4], intensity_t sun_intensity);
//void ProgramSetBlendFactor(factor_t factor, ms_t duration);
//void ProgramSetStrobeWeights(factor_t strip_weights[4], factor_t sun_weight);
//void ProgramStrobe(hsv_t strip_colors, intensity_t sun_intensity, ms_t on, ms_t off, uint8_t count);
//void ProgramGetOutputColors(hsv_t (&out_strip_colors)[4], intensity_t &sun_intensity);
//
//static void MixColor(factor_t factor, hsv_t from, hsv_t to, hsv_t& out);
//static void MixIntensity(factor_t factor, intensity_t from, intensity_t to, intensity_t& out);
//
//factor_t    BlenderGetFactor();
//
//static long          blender_last_set_color_timestamp;
//static int           blender_swap_index= 0;
//static factor_t      blender_factor;
//
//void MixColor(factor_t factor, hsv_t from, hsv_t to, hsv_t& out) {
//  uint32_t c;
//  const factor_t inv_factor = (10000 - factor);
//  for(int i; i < 4; i++) {
//    c  = from.channel[i] * inv_factor;
//    c += to.channel[i] * factor;
//    c /= 10000;
//    out.channel[i] = c;
//  }
//}
//
//void MixIntensity(factor_t factor, intensity_t from, intensity_t to, intensity_t& out) {
//  uint32_t c;
//  c  = from * (10000 - factor);
//  c += to * factor;
//  c /= 10000;
//  out = c;
//}
//
//static hsv_t blender_strip_colors_from[4];
//static hsv_t blender_strip_colors_to[4];
//static hsv_t blender_strip_colors[4];
//
//static intensity_t blender_sun_intensity_from;
//static intensity_t blender_sun_intensity_to;
//static intensity_t blender_sun_intensity;
//
//void BlenderLoop() {
//  factor_t factor = BlenderGetFactor();
//  for (int i = 0; i < 4; i++) {
//    MixColor(factor, blender_strip_colors_from[i], blender_strip_colors_to[i], blender_strip_colors[i]);
//  }
//  MixIntensity(factor, blender_sun_intensity_from, blender_sun_intensity_to, blender_sun_intensity);
//}
//
//static uint16_t blender_from_factor;
//static uint16_t blender_to_factor;
//static uint16_t blender_to_timestamp;
//static uint16_t blender_fade_time;
//
//factor_t BlenderGetFactor() {
//  const uint16_t timestamp = millis();
//  const int32_t  time_left = (int32_t)blender_to_timestamp - blender_timestamp_from;
//  
//  if (time_passed <= 0) {
//    blender_to_timestamp = timestamp();
//    return 10000;
//  }
//
//  uint32_t result;
//  
//
//  return result;
//}
//
//void BlenderSetNextColors(hsv_t strip_colors[4], intensity_t sun_intensity);
//void BlenderSetNextColors(hsv_t strip_colors[4], intensity_t sun_intensity) {
//  
//}
//
//
//void ProgramLoop() {
//  BlenderLoop();
//}
//
//void MixerGet() {
//  long timestamp = millis();
//}
//
//void ProgramSetNextColors(hsv_t strip_colors[4], intensity_t sun_intensity) {
//  
//    
//}



