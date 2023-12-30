#include <Arduino.h>

#include "Bootloader.h"
#include "DeviceId.h"
#include "Log.h"
#include "Report.h"

#include "Command.h"

typedef bool (*interpretter_t)(byte b);

static interpretter_t interpretter = NULL;
static int command_device_id;
static interpretter_t CommandExecute(char command_id);
static interpretter_t WhoCommand();
static interpretter_t BootCommand();
static interpretter_t ReportCommand();
static interpretter_t DebugCommand();
static bool CommandReadInt(uint8_t b, int &i);
static void CommandReadLine(byte b);

void CommandLoop() {
  while (Serial.available()) {
    uint8_t b = Serial.read();
    CommandReadLine(b);
  }
}

static interpretter_t CommandExecute(char command_id) {
  if(command_device_id == 0 || command_device_id == DeviceIdGet()) {
    switch (command_id) {
      case 'r': return ReportCommand();
      case 'b': return BootCommand();
    }
  }
  switch (command_id) {
    case 'w': return WhoCommand();
    case 'd': return DebugCommand();
  }
  return NULL;
}

static interpretter_t WhoCommand() {
  if(command_device_id == 0) {
    delay(100 * DeviceIdGet());
    LogPrintln("");
  }
  return NULL;
}

static interpretter_t BootCommand() {
  BootloaderExecute();
  return NULL;
}

static interpretter_t ReportCommand() {
  if(command_device_id == 0) {
    delay(500 * DeviceIdGet());
  }
  ReportLog();
  
  return NULL;
}

static interpretter_t DebugCommand() {
  ReportPeriodically(command_device_id == DeviceIdGet());
  return NULL;
}

static bool CommandReadInt(uint8_t b, int &i) {
  if(b >= '0' && b < '9') {
    i *= 10;
    i += b - '0';
    return true;
  } else {
    return false;
  }
}

static void CommandReadLine(byte b) {
  static enum {
    IDLE,
    DEVICE_ID,
    COMMAND_ID,
    COMMAND,
    CLEAN_UP,
    LINE_END
  } state = IDLE;
  
  
  switch(state) {
    for(;;) {
      case IDLE:
        
        command_device_id = 0;
        state             = DEVICE_ID;
        // Fall-through
      case DEVICE_ID:
        if(CommandReadInt(b, command_device_id)) return;
        state = COMMAND;
        // Fall-trough
      case COMMAND_ID:
        {
          char command_id = b;
          interpretter = CommandExecute(command_id);
          state = (interpretter) ? COMMAND : CLEAN_UP;
          return;
        }
      case COMMAND:
        if(interpretter && interpretter(b)) return;
        state = CLEAN_UP;
        // Fall-trough
      case CLEAN_UP:
        if (b != '\r' && b != '\n') return;
        state = LINE_END;
        // Fall-trough
      case LINE_END:
        if (b == '\r' || b == '\n') return;
        continue;
    }
    break;
  }
}

