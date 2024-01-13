#include <Arduino.h>

#include "Command.h"
#include "DeviceId.h"
#include "Led.h"

#include "Error.h"

static uint8_t error_state_bits = 0;
static uint8_t send_error_raised_command_bits = 0;
static uint8_t send_error_activate_command_bits = 0;
static uint8_t send_error_deactivate_command_bits = 0;

void ErrorLoop() {
  if (CommandCanSend() && (send_error_raised_command_bits || send_error_activate_command_bits || send_error_deactivate_command_bits)) {
    CommandSend([](char* buffer, size_t size, bool talk_at_will) -> size_t {
      const char* event = nullptr;
      int error_nr;
      uint8_t* command_bits;
        
      for(error_nr = 0; error_nr < 8; error_nr++) {
        uint8_t b = bit(error_nr);
        if(send_error_raised_command_bits & b) {
          send_error_raised_command_bits &= ~b;
          event = "fired";
          break;
        } else  if(send_error_activate_command_bits & b) {
          send_error_activate_command_bits &= ~b;
          event = "raised";
          break;
        } else if(send_error_deactivate_command_bits & b) {
          send_error_deactivate_command_bits &= ~b;
          event = "cleared";
          break;
        }
      }
      if (talk_at_will && (error_nr == ERROR_COMMUNICATION || error_nr == ERROR_COMM_BUSY)) {
        return 0; // Skip communication error when talking at will
      }
      if (event) {
        int device_id = DeviceIdGet();
        size_t s = snprintf ( buffer, size, "#%d: error(%d, %s)", device_id, error_nr, event);
        if(s <= size && s > 0) {
          return s;
        }
      } 
      return 0;
    });
  }
}

static inline int ErrorToBlinkCount(error_t error) {
  return error + 1;
}

void ErrorActivate(error_t error) {
  if((error_state_bits & bit(error)) == 0) {
    error_state_bits |= bit(error);
    send_error_activate_command_bits |= bit(error);
    LedBlinkCount(LED_RED, ErrorToBlinkCount(error), true);
  }
}

void ErrorDeactivate(error_t error) {
  if((error_state_bits & bit(error)) != 0) {
    error_state_bits &= ~bit(error);
    send_error_deactivate_command_bits |= bit(error);
    if(error_state_bits) {
      for(int old_error = 0; old_error < 8; old_error++) {
        if((error_state_bits & bit(old_error)) != 0) {
          LedBlinkCount(LED_RED, ErrorToBlinkCount(static_cast<error_t>(old_error)), true);
          return;
        }
      }
    }
    LedSet(LED_RED, LED_OFF);
  }
}

void ErrorRaise(error_t error) {
  if(!error_state_bits) {
    send_error_raised_command_bits |= bit(error);
    LedBlinkCount(LED_RED, ErrorToBlinkCount(error), false);
  }
}

