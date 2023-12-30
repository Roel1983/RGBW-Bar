#include <stdarg.h>
#include <stdio.h>

#include "Comm.h"
#include "DeviceId.h"
#include "Log.h"

void LogPrintln(const char *format, ...) {
  va_list args;
  
  va_start(args, format);
  int size = vsnprintf (NULL, 0, format, args);
  va_end(args);

  char buffer[2 + size + 1 + 1];
  buffer[0] = '0' + DeviceIdGet();
  buffer[1] = ':';
  va_start(args, format);
  vsnprintf (buffer + 2, size + 1, format, args);
  va_end(args);
  
  buffer[2 + size] = '\n';
  buffer[2 + size + 1] = '\0';

  CommSend(buffer, size);
}

