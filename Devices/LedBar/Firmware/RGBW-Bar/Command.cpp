#include <Arduino.h>

#include "Bootloader.h"
#include "Color.h"
#include "DeviceId.h"
#include "Error.h"
#include "Fade.h"
#include "Log.h"
#include "Report.h"
#include "Strobe.h"
#include "Types.h"

#include "Command.h"

using color_t = color_rgbw_t;

void CommandLoop() {
  static byte buffer[40];
  static unsigned int pos = 0;
  static int state = -1;
  static void (*cmd)(char*, size_t);
  
  while (Serial.available()) {
    uint8_t b = Serial.read();

    switch(state) {
    case -1:
      if (b == '\r' || b == '\n' || b == ';') {
        return;
      }
      state = 0;
      pos   = 0;
      // Fall-though
    case 0: // Command
    {
      bool is_alpha = (b >= 'a' && b <= 'z') || (b > 'A' && b <= 'Z');
      if (is_alpha) {
        if(pos >= sizeof(buffer) - 1) {
          LogPrintln("Command too long");
          state = 2; // skip till end
          return;
        }
        buffer[pos++]= b;
        return;
      } else {
        if (b != '(') {
          ErrorRaise(ERROR_COMMUNICATION);
          LogPrintln("did expect '(' got '%c'", b);
          state = 2; // skip till end
          return;
        }
        buffer[pos] = '\0';
        if (!strcmp(buffer, "echo")) {
          cmd = [](char* args, size_t len) {
            LogPrintln("echo(%s)", args);
            char msg[40];
            int res = sscanf(args, "%s", msg);
            if(1 == res) {;
              LogPrintln("echoing: \"%s\"", msg);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
              LogPrintln("invalid args. res=%d, len=%d, args=\"%s\"",res, len, args);
            }
          };
        } else if(!strcmp(buffer, "fade")) {
          cmd = [](char* args, size_t len) {
            LogPrintln("fade(%s)", args);
            int factor;
            int duration = 0;
            int res = sscanf(args, "%d, %d", &factor, &duration);
            if(res >= 1) {
              FadeSetTargetFactor(factor, (ms_t)duration * 1000);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
              LogPrintln("invalid args. res=%d, len=%d, args=\"%s\"",res, len, args);
            }
          };
        } else if(!strcmp(buffer, "set")) {
          cmd = [](char* args, size_t len) {
            LogPrintln("set(%s)", args);
            int index;
            color_t c;
            int res = sscanf(args, "%d,%d,%d,%d,%d", &index, &c[0], &c[1], &c[2], &c[3]);
            if(res == 2) {
              c[1] = c[0];
              c[2] = c[0];
              c[3] = c[0];
              FadeSetTargetColor(index, c);
            } else if (res == 4) {
              c[3] = 0;
              FadeSetTargetColor(index, c);
            } else if (res == 5) {
              FadeSetTargetColor(index, c);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
              LogPrintln("invalid args. res=%d, len=%d, args=\"%s\"",res, len, args);
            }
          };
        } else if(!strcmp(buffer, "report")) {
          cmd = [](char* args, size_t len) {
            LogPrintln("report(%s)", args);
            int device_id;
            int res = sscanf(args, "%d", &device_id);
            if(res == 1) {
              ReportPeriodically(DeviceIdGet() == device_id);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
            }
          };
        } else if(!strcmp(buffer, "strobe")) {
          cmd = [](char* args, size_t len) {
            LogPrintln("strobe(%s)", args);
            int on;
            int off;
            int count;
            int res = sscanf(args, "%d,%d,%d", &on,&off,&count);
            if(res == 3) {
              Strobe(on, off, count);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
            }
          };
        } else if(!strcmp(buffer, "strobeColor")) {
          cmd = [](char* args, size_t len) {
            LogPrintln("strobeColor(%s)", args);
            int index;
            color_t c;
            int res = sscanf(args, "%d,%d,%d,%d,%d", &index, &c[0], &c[1], &c[2], &c[3]);
            if(res == 2) {
              c[1] = c[0];
              c[2] = c[0];
              c[3] = c[0];
              StrobeSetStripColor(index, c);
            } else if (res == 4) {
              c[3] = 0;
              StrobeSetStripColor(index, c);
            } else if (res == 5) {
              StrobeSetStripColor(index, c);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
              LogPrintln("invalid args. res=%d, len=%d, args=\"%s\"",res, len, args);
            }
          };
        } else if(!strcmp(buffer, "strobeWeight")) {
          cmd = [](char* args, size_t len) {
            LogPrintln("strobeWeight(%s)", args);
            factor_t weights[4];
            int res = sscanf(args, "%d,%d,%d,%d,%d", &weights[0], &weights[1], &weights[2], &weights[3]);
            if(res == 4) {
              StrobeSetStripWeights(weights);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
              LogPrintln("invalid args. res=%d, len=%d, args=\"%s\"",res, len, args);
            }
          };
        } else {
          ErrorRaise(ERROR_COMMUNICATION);
          LogPrintln("unknown command");
          state = 2; // skip till end
          return;
        }
        pos = 0;
        state = 1; // Args
      }
      break;
    }
    case 1: // args
      if (b == ')') {
        buffer[pos] = '\0';
        cmd(buffer, pos);
        state = -1;
      } else if (b == '\r' || b == '\n') {
        LogPrintln("args incomplete");
        ErrorRaise(ERROR_COMMUNICATION);
        state = -1;
        return;
      } else {
        if(pos >= sizeof(buffer) - 1) {
          LogPrintln("args incomplete");
          state = 2; // skip till end
          return;
        }
        buffer[pos++]= b;
      }
      break;
    case 2: // skip till end 
      if (b == '\r' || b == '\n') {
        state = -1;
      }
    }
  }
}
