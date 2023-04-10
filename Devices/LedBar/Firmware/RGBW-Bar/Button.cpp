#include <Arduino.h>

// TODO Use enums instead of ints for state variables

static constexpr int  button_pinnr           =   14;
static constexpr int  button_active_state    =  LOW;
static constexpr int  button_debound_delay   =   10;
static constexpr long button_long_press      =  500;
static constexpr long button_very_long_press = 5000;

static int  button_event;
static bool button_new_event;
void ButtonBegin() {
  pinMode(button_pinnr, INPUT_PULLUP);
}

void ButtonLoop() {
  static int  state = -1;
  static long pressed_timestamp;
  static long release_timestamp;
  
  bool is_pressed = (digitalRead(button_pinnr) == button_active_state);

  long current_timestamp = millis();
  button_new_event = false;

  switch(state) {
  case -1:
    if(!is_pressed) {
      state = 0;
    }
    break;
  case 0:
    if(is_pressed) {
      pressed_timestamp = current_timestamp;
      state = 1;
      button_event = 0;
    }
    break;
  case 3:
    if(is_pressed) {
      state = 1;
    } else {
      if (millis() - release_timestamp > button_debound_delay) {
        if (button_event == 0) {
          button_event = 1;
          button_new_event = true;
        }
        state = 0;
      }
      break;
    }
  case 1: // Fall-through
    if(!is_pressed) {
      release_timestamp = current_timestamp;
      state = 3;
    } else {
      if(button_event == 0) {
        if (current_timestamp - pressed_timestamp > button_long_press) {
          button_event = 2;
          button_new_event = true;
        }
      } else if(button_event == 2) {
        if (current_timestamp - pressed_timestamp > button_very_long_press) {
          button_event = 3;
          button_new_event = true;
        }
      }
    }
  }
}

bool ButtonIsPressedShort() {
  return button_new_event && button_event == 1;
}

bool ButtonIsPressedLong() {
  return button_new_event && button_event == 2;
}

bool ButtonIsPressedVeryLong() {
  return button_new_event && button_event == 3;
}
