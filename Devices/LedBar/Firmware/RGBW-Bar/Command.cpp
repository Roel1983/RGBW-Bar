#include <Arduino.h>

#include "Bootloader.h"
#include "Color.h"
#include "DeviceId.h"
#include "Error.h"
#include "Fade.h"
#include "Led.h"
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
      if (b == '\r' || b == '\n' || b == ';' || (b >= '0' && b <= '9')) {
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
          ErrorRaise(ERROR_COMMUNICATION);
          state = 2; // skip till end
          return;
        }
        buffer[pos++]= b;
        return;
      } else {
        if (b != '(') {
          ErrorRaise(ERROR_COMMUNICATION);
          state = 2; // skip till end
          return;
        }
        buffer[pos] = '\0';
        if (!strcmp(buffer, "echo")) {
          cmd = [](char* args, size_t len) {
            int device_id;
            char msg[40];
            int res = sscanf(args, "%d,%s", &device_id, msg);
            if(2 == res) {;
              if(DeviceIdGet() == device_id) {
                LogPrintln("echoing: \"%s\"", msg);
              }
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
            }
          };
        } else if (!strcmp(buffer, "boot")) {
          cmd = [](char* args, size_t len) {
            int device_id;
            int res = sscanf(args, "%d", &device_id);
            if(1 == res) {
              if(DeviceIdGet() == device_id) {
                LogPrintln("bootloader in 3 seconds (silent)");
                delay(1000);
                BootloaderExecute();
              } else {
                Serial.end();
                delay(1000);
                long b = (long)57600 * 1600 / 1475;
                Serial.begin(b);
                delay(2000);

                while(Serial.available()) {
                  while(Serial.read() != -1);
                  delay(1000);
                } // Wail till the bus is idle for at least 1 second

                Serial.end();
                delay(1000);
                b = (long)115200 * 1600 / 1475; // 
                Serial.begin(b);
                delay(1000);
              }
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
            }
          };
        } else if(!strcmp(buffer, "fade")) {
          cmd = [](char* args, size_t len) {
            int factor;
            int duration = 0;
            int res = sscanf(args, "%d, %d", &factor, &duration);
            if(res >= 1) {
              FadeSetTargetFactor(factor, (ms_t)duration * 1000);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
            }
          };
        } else if(!strcmp(buffer, "set")) {
          cmd = [](char* args, size_t len) {
            int device_id;
            int index;
            color_t c;
            int res = sscanf(args, "%d,%d,%d,%d,%d,%d", &device_id, &index, &c[0], &c[1], &c[2], &c[3]);
            if(res == 3) {
              c[1] = c[0];
              c[2] = c[0];
              c[3] = c[0];
              if(DeviceIdGet() == device_id) FadeSetTargetColor(index, c);
            } else if (res == 5) {
              c[3] = 0;
              if(DeviceIdGet() == device_id) FadeSetTargetColor(index, c);
            } else if (res == 6) {
              if(DeviceIdGet() == device_id) FadeSetTargetColor(index, c);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
            }
          };
        } else if(!strcmp(buffer, "report")) {
          cmd = [](char* args, size_t len) {
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
            int device_id;
            int index;
            color_t c;
            int res = sscanf(args, "%d,%d,%d,%d,%d,%d", &device_id, &index, &c[0], &c[1], &c[2], &c[3]);
            if(res == 3) {
              c[1] = c[0];
              c[2] = c[0];
              c[3] = c[0];
              if(DeviceIdGet() == device_id) StrobeSetStripColor(index, c);
            } else if (res == 5) {
              c[3] = 0;
              if(DeviceIdGet() == device_id) StrobeSetStripColor(index, c);
            } else if (res == 6) {
              if(DeviceIdGet() == device_id) StrobeSetStripColor(index, c);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
            }
          };
        } else if(!strcmp(buffer, "strobeWeight")) {
          cmd = [](char* args, size_t len) {
            int device_id;
            factor_t weights[4];
            int res = sscanf(args, "%d,%d,%d,%d,%d", &device_id, &weights[0], &weights[1], &weights[2], &weights[3]);
            if(res == 5) {
              if(DeviceIdGet() == device_id) StrobeSetStripWeights(weights);
            } else {
              ErrorRaise(ERROR_COMMUNICATION);
            }
          };
        } else {
          ErrorRaise(ERROR_COMMUNICATION);
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
