#ifndef COLOR_H_
#define COLOR_H_

typedef union {
  uint16_t channel[4];
  struct {
    union {uint16_t r; uint16_t red;};
    union {uint16_t g; uint16_t green;};
    union {uint16_t b; uint16_t blue;};
    union {uint16_t w; uint16_t white;};
  };
} color_rgbw_t;

#endif // COLOR_H_